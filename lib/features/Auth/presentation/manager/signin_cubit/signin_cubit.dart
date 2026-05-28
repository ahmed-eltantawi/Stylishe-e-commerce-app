import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/features/Auth/data/models/signin_response_model.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo_implementation.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepoImplementation authRepo;
  //* =========== Sign in Controllers ===========
  TextEditingController emailSigninController = TextEditingController();

  TextEditingController passwordSigninController = TextEditingController();
  GlobalKey<FormState> formKeySignin = GlobalKey<FormState>();

  SigninCubit({required this.authRepo}) : super(SigninInitial());

  //* =========== Sign in Method ===========
  void signin() async {
    // check if user input is valid
    if (formKeySignin.currentState!.validate()) {
      emit(SignInLoading());

      // send request
      final response = await authRepo.singIn(
        email: emailSigninController.text.replaceAll(" ", ""),
        password: passwordSigninController.text.replaceAll(" ", ""),
      );

      // check response and emit state
      response.fold(
        (leftSide) {
          if (leftSide == AppConstants.noInternetConnection) {
            emit(NoInternetConnection());
          } else {
            emit(SignInFailure(errorMessage: leftSide));
          }
        },
        (rightSide) {
          emit(SignInSuccess(signinModel: rightSide));
        },
      );
    }
  }
}
