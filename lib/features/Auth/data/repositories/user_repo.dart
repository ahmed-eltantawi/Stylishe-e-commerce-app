import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stylish/core/api/dio_consumer.dart';
import 'package:stylish/core/api/end_points.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/constants/app_constants.dart';
import 'package:stylish/core/errors/error_model.dart';
import 'package:stylish/core/errors/exceptions.dart';
import 'package:stylish/core/services/services_locator.dart';
import 'package:stylish/features/Auth/data/models/signin_model.dart';
import 'package:stylish/features/Auth/data/models/signup_model.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';

class UserRepo {
  const UserRepo({required this.dioConsumer});
  final DioConsumer dioConsumer;

  //* ======= Implementation of sign in method =======
  Future<Either<String, SigninModel>> singIn({
    required String email,
    required String password,
  }) async {
    try {
      //--- send request ---

      final response = await dioConsumer.post(
        EndPoint.login,
        data: {ApiKey.email: email, ApiKey.password: password},
      );
      final signinModel = SigninModel.fromJson(response);

      //--- save token on local storage ---

      // save access token
      getIt<CacheHelper>().saveData(
        key: ApiKey.accessToken,
        value: signinModel.accessToken,
      );
      // save refresh token
      getIt<CacheHelper>().saveData(
        key: ApiKey.refreshToken,
        value: signinModel.refreshToken,
      );

      //!
      // save id
      // // --- get user data from api ---
      // final userData = await getUserDataFromApi();
      // userData.fold((leftSide) {
      //   return Left(leftSide);
      // }, (rightSide) => UserModel.fromJson(response, id: id));
      //!

      //--- return response to Cubit ---
      return Right(signinModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  //* ======= Implementation of sign up method =======
  Future<Either<String, SignUpModel>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      return const Left('Passwords do not match');
    }
    try {
      final response = await dioConsumer.post(
        EndPoint.register,
        data: {
          ApiKey.name: email.split('@')[0],
          ApiKey.avatar: AppConstants.defaultAvatarUrl,
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );

      return Right(SignUpModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  //* ======= Implementation of sign out method =======
  Future<Either<String, Success>> signOut() async {
    try {
      // --- remove data from local storage ---
      await getIt<CacheHelper>().removeData(key: ApiKey.accessToken);
      await getIt<CacheHelper>().removeData(key: ApiKey.refreshToken);
      await getIt<CacheHelper>().removeData(key: ApiKey.tokenId);
      await getIt<CacheHelper>().removeData(key: AppConstants.userDataKey);

      // --- return response to Cubit ---
      return const Right(Success());
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  //* ======= Implementation of get User data method =======
  Future<Either<String, UserModel>> getUserDataFromApi() async {
    try {
      // --- get id from access token ---
      final int id = JwtDecoder.decode(
        getIt<CacheHelper>().getString(key: ApiKey.accessToken)!,
      )[ApiKey.tokenId];

      // --- save id on local storage ---
      getIt<CacheHelper>().saveData(key: ApiKey.tokenId, value: id);

      UserModel userModel;

      // this if statement check if user data is in local storage
      if (getIt<CacheHelper>().getData(key: AppConstants.userDataKey) == null) {
        // --- get user data from api ---
        final response = await dioConsumer.get(EndPoint.getUser(id: id));
        userModel = UserModel.fromJson(response, id: id);
        // --- save user data on local storage ---
        await getIt<CacheHelper>().saveData(
          key: AppConstants.userDataKey,
          value: jsonEncode(userModel.toJson()),
        );
      } else {
        // --- get user data from local storage ---
        userModel = UserModel.fromJson(
          jsonDecode(
            getIt<CacheHelper>().getData(key: AppConstants.userDataKey),
          ),
          id: id,
        );
      }

      //--- return response to Cubit ---
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
