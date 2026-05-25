import 'package:dartz/dartz.dart';
import 'package:stylish/core/api/dio_consumer.dart';
import 'package:stylish/core/api/end_points.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/errors/exceptions.dart';
import 'package:stylish/features/Auth/data/models/signin_model.dart';
import 'package:stylish/features/Auth/data/models/signup_model.dart';

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
      //--- save token on local storage ---
      final signinModel = SigninModel.fromJson(response);
      CacheHelper().saveData(
        key: ApiKey.accessToken,
        value: signinModel.accessToken,
      );
      CacheHelper().saveData(
        key: ApiKey.refreshToken,
        value: signinModel.refreshToken,
      );

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
          ApiKey.avatar:
              "https://i.pinimg.com/736x/bd/42/8e/bd428e6bb156d90045700dbf3e967c3e.jpg",
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );
      return Right(SignUpModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
