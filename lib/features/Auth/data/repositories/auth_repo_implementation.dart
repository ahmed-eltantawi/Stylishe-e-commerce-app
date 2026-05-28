import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stylish/config/services/secure_storage_service.dart';
import 'package:stylish/config/services/shared_preferences_service.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/core/networking/api_end_points.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';
import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/core/errors/error_model.dart';
import 'package:stylish/core/errors/exceptions.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/features/Auth/data/models/signin_response_model.dart';
import 'package:stylish/features/Auth/data/models/signup_request_model.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo.dart';

//! ====== This Repo contains all methods Implementation related to user ======
class AuthRepoImplementation extends AuthRepo {
  AuthRepoImplementation({required this.dioConsumer});
  final DioConsumer dioConsumer;

  //*--------------------------------------------------------------
  //* ======= Implementation of sign in method =======
  //*--------------------------------------------------------------
  @override
  Future<Either<String, SignInResponseModel>> singIn({
    required String email,
    required String password,
  }) async {
    //--- check internet connection ---
    if (!await _isConnectedToInternet()) {
      return const Left(AppConstants.noInternetConnection);
    }

    try {
      //--- send request ---
      final response = await dioConsumer.post(
        EndPoint.login,
        data: {ApiKey.email: email, ApiKey.password: password},
      );
      final signinResponseModel = SignInResponseModel.fromJson(response);

      //--- save tokens on secure local storage ---
      SecureStorageService.saveTokens(
        accessToken: signinResponseModel.accessToken,
        refreshToken: signinResponseModel.refreshToken,
      );

      // --- save logged in status ---
      SharedPreferencesService.setLoggedIn(true);

      // --- save User data on local storage ---
      await getUserData();
      //--- return response to Cubit ---
      return Right(signinResponseModel);

      //--- catch error ---
    } on ServerException catch (e) {
      if (e.errorModel.statusCode == 401) {
        return const Left('Incorrect email or password');
      }
      return Left(e.errorModel.errorMessage);
    }
  }

  //*--------------------------------------------------------------
  //* ======= Implementation of sign up method =======
  //*--------------------------------------------------------------
  @override
  Future<Either<String, Success>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // check if password & confirmPassword match
    if (password != confirmPassword) {
      return const Left('Passwords do not match');
    }

    try {
      // here we check if email is already used and password
      // is valid for same email. then if it right
      // we will sing in directly and go to home page
      final tryToLogin = await singIn(email: email, password: password);
      if (tryToLogin.isRight()) {
        return Right(Success());
      }

      // return no internet connection if sign in method gives that
      final error = tryToLogin.fold((l) => l, (r) => '');
      if (error == AppConstants.noInternetConnection) {
        return const Left(AppConstants.noInternetConnection);
      }

      // if email is don't valid with password
      // The problem here is the Api don't tell us
      // if the email is used before or not
      // So I will sing up then try to sing in
      // if it works then the email isn't used before
      // else the email is used before
      await dioConsumer.post(
        EndPoint.register,
        data: SignupRequestModel(
          // user can change name & avatar later
          name: email.split('@')[0],
          email: email,
          password: password,
          avatar: AppConstants.defaultAvatarUrl,
        ).toJson(),
      );

      // trying to sing in with the email and password
      final signInResponse = await singIn(email: email, password: password);
      if (signInResponse is Right) {
        return Right(Success());
      } else {
        return Left("This email is already used, try another one");
      }

      // I made this SignUpErrorModel class because the
      // Api returns a different error message
      // if the statues code is 400 in the signup endpoint
      // the api sends a List of error messages
      // instead of a single error message on (key: value) format
    } on SignUpErrorModel catch (e) {
      return Left(e.errorMessage);
    } on ServerException catch (e) {
      if (e.errorModel.statusCode == 400) {}
      return Left(e.errorModel.errorMessage);
    }
  }

  //*--------------------------------------------------------------
  //* ======= Implementation of sign out method =======
  //*--------------------------------------------------------------
  @override
  Future<Either<String, Success>> signOut() async {
    try {
      // --- remove Auth data from local storage ---
      await SecureStorageService.deleteTokens();
      await SharedPreferencesService.clearAuthData();

      // --- return response to Cubit ---
      return const Right(Success());
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  //*--------------------------------------------------------------
  //* ======= Implementation of get User data method =======
  //*--------------------------------------------------------------
  @override
  Future<Either<String, UserModel>> getUserData() async {
    try {
      UserModel userModel;

      // this if statement make sure that
      // the user data is not in local storage
      if (getIt<CacheHelper>().getData(key: CacheKey.userDataKey) == null) {
        // --- if it is true it will get user data from api ---

        // --- get id from access token ---
        final String? accessToken = await SecureStorageService.getAccessToken();
        if (accessToken == null) return const Left('No access token');
        final int id = JwtDecoder.decode(accessToken)[ApiKey.tokenId];

        // --- save id on local storage ---
        getIt<CacheHelper>().saveData(key: CacheKey.id, value: id);

        //--- check internet connection ---
        if (!await _isConnectedToInternet()) {
          return const Left(AppConstants.noInternetConnection);
        }

        // --- get user data from api ---
        final response = await dioConsumer.get(EndPoint.getUser(id: id));
        userModel = UserModel.fromJson(response, id: id);

        // --- save user data on local storage ---
        await getIt<CacheHelper>().saveData(
          key: CacheKey.userDataKey,
          value: jsonEncode(userModel.toJson()),
        );
      } else {
        // --- get user data from local storage ---
        userModel = UserModel.fromJson(
          jsonDecode(getIt<CacheHelper>().getData(key: CacheKey.userDataKey)),
          id: getIt<CacheHelper>().getData(key: CacheKey.id),
        );
      }

      //--- return response to Cubit ---
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  //* -------- This method checks if there is internet connection --------
  Future<bool> _isConnectedToInternet() async {
    return await InternetConnection().hasInternetAccess;
  }
}
