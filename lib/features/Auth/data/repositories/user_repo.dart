import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stylish/core/api/dio_consumer.dart';
import 'package:stylish/core/api/end_points.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';
import 'package:stylish/core/constants/app_constants.dart';
import 'package:stylish/core/errors/error_model.dart';
import 'package:stylish/core/errors/exceptions.dart';
import 'package:stylish/core/services/services_locator.dart';
import 'package:stylish/features/Auth/data/models/signin_model.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';

//! ====== This Repo contains all methods Implementation related to user ======
class UserRepo {
  const UserRepo({required this.dioConsumer});
  final DioConsumer dioConsumer;
  final List<String> localDataBaseKeys = const [
    CacheKey.accessToken,
    CacheKey.refreshToken,
    CacheKey.id,
    CacheKey.userDataKey,
  ];
  //*--------------------------------------------------------------
  //* ======= Implementation of sign in method =======
  //*--------------------------------------------------------------
  Future<Either<String, SignInModel>> singIn({
    required String email,
    required String password,
  }) async {
    //--- check internet connection ---
    if (!await _isConnectedToInternet()) {
      return const Left('No internet connection');
    }

    try {
      //--- send request ---
      final response = await dioConsumer.post(
        EndPoint.login,
        data: {ApiKey.email: email, ApiKey.password: password},
      );
      final signinModel = SignInModel.fromJson(response);

      //--- save tokens on local storage ---
      // save access token
      getIt<CacheHelper>().saveData(
        key: CacheKey.accessToken,
        value: signinModel.accessToken,
      );
      // save refresh token
      getIt<CacheHelper>().saveData(
        key: CacheKey.refreshToken,
        value: signinModel.refreshToken,
      );

      //--- return response to Cubit ---
      return Right(signinModel);
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
  Future<Either<String, Success>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // check if password & confirmPassword match
    if (password != confirmPassword) {
      return const Left('Passwords do not match');
    }

    //--- check internet connection ---
    if (!await _isConnectedToInternet()) {
      return const Left('No internet connection');
    }
    try {
      // here we check if email is already used and password
      // is valid for same email. then if it right
      // we will sing in directly and go to home page
      final holder = await singIn(email: email, password: password);
      if (holder is Right) {
        return Right(Success());
      }

      // if email is don't valid with password
      // The problem here is the Api don't tell us
      // if the email is used before or not
      // So I will sing up then try to sing in
      // if it works then the email isn't used before
      // else the email is used before
      await dioConsumer.post(
        EndPoint.register,
        data: {
          // user can change name any time & avatar later
          ApiKey.name: email.split('@')[0],
          ApiKey.avatar: AppConstants.defaultAvatarUrl,
          ApiKey.email: email,
          ApiKey.password: password,
        },
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
  Future<Either<String, Success>> signOut() async {
    try {
      // --- remove data from local storage ---
      for (String key in localDataBaseKeys) {
        await getIt<CacheHelper>().removeData(key: key);
      }

      // --- return response to Cubit ---
      return const Right(Success());
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  //*--------------------------------------------------------------
  //* ======= Implementation of get User data method =======
  //*--------------------------------------------------------------
  Future<Either<String, UserModel>> getUserDataFromApi() async {
    try {
      // --- get id from access token ---
      final int id = JwtDecoder.decode(
        getIt<CacheHelper>().getString(key: CacheKey.accessToken)!,
      )[ApiKey.tokenId];

      // --- save id on local storage ---
      getIt<CacheHelper>().saveData(key: CacheKey.id, value: id);

      UserModel userModel;

      // this if statement make sure that
      // the user data is not in local storage
      if (getIt<CacheHelper>().getData(key: CacheKey.userDataKey) == null) {
        // --- if it is true it will get user data from api ---

        //--- check internet connection ---
        if (!await _isConnectedToInternet()) {
          return const Left('No internet connection');
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
          id: id,
        );
      }

      //--- return response to Cubit ---
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<bool> _isConnectedToInternet() async {
    return await InternetConnection().hasInternetAccess;
  }
}
