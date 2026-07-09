import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/error_model.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/features/Auth/data/models/signin_response_model.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';

abstract class AuthRepo {
  ///* this method is used to sign in with email and password
  Future<Either<Failure, SignInResponseModel>> singIn({
    required String email,
    required String password,
  });

  ///* This method is used to create new account with email, password and confirm password
  Future<Either<Failure, Success>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  ///* This method is used to sign out and clear local storage
  Future<Either<Failure, Success>> signOut();

  ///* This method is used to get user data from local storage and api
  Future<Either<Failure, UserModel>> getUserData();
}
