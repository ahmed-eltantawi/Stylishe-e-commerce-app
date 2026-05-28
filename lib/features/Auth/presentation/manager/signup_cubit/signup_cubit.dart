import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo_implementation.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepoImplementation authRepo;
  SignupCubit({required this.authRepo}) : super(SignupInitial());

  //* --- Sign up Controllers ---
  TextEditingController emailSignupController = TextEditingController();
  TextEditingController passwordSignupController = TextEditingController();
  TextEditingController confirmPasswordSignupController =
      TextEditingController();
  GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();

  //* --- Sign up Method ---
  void signUp() async {
    // check if user input is valid
    if (formKeySignup.currentState!.validate()) {
      emit(SignUpLoading());

      // send request
      final response = await authRepo.signUp(
        email: emailSignupController.text,
        password: passwordSignupController.text,
        confirmPassword: confirmPasswordSignupController.text,
      );

      // check response and emit state
      response.fold(
        (leftSide) {
          if (leftSide == AppConstants.noInternetConnection) {
            emit(NoInternetConnection());
          } else {
            emit(SignUpFailure(errorMessage: leftSide));
          }
        },

        (rightSide) {
          emit(SignUpSuccess());
        },
      );
    }
  }
}
