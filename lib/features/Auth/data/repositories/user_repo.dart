import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/error_model.dart';
import 'package:stylish/features/Auth/data/models/signin_response_model.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<String, SignInResponseModel>> singIn({
    required String email,
    required String password,
  });

  Future<Either<String, Success>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<String, Success>> signOut();

  Future<Either<String, UserModel>> getUserDataFromApi();
}
