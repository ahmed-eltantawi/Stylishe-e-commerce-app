import 'package:flutter/material.dart';
import 'package:stylish/features/Auth/data/models/signin_response_model.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';
import 'package:stylish/features/Auth/data/repositories/user_repo_implementation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepo}) : super(UserInitial());
  final UserRepoImplementation userRepo;

  //? ======================= Controllers ==============================
  //* --- Sign in Controllers ---
  TextEditingController emailSigninController = TextEditingController();

  TextEditingController passwordSigninController = TextEditingController();
  GlobalKey<FormState> formKeySignin = GlobalKey<FormState>();

  //* --- Sign up Controllers ---
  TextEditingController emailSignupController = TextEditingController();
  TextEditingController passwordSignupController = TextEditingController();
  TextEditingController confirmPasswordSignupController =
      TextEditingController();
  GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();

  //?===========================================================
  //?========================= Methods =========================
  //* --- Sign in Method ---
  void signin() async {
    // check if user input is valid
    if (formKeySignin.currentState!.validate()) {
      emit(UserSignInLoading());

      // send request
      final response = await userRepo.singIn(
        email: emailSigninController.text.replaceAll(" ", ""),
        password: passwordSigninController.text.replaceAll(" ", ""),
      );

      // check response and emit state
      response.fold(
        (leftSide) => emit(UserSignInFailure(errorMessage: leftSide)),
        (rightSide) {
          emit(UserSignInSuccess(signinModel: rightSide));
          getUserDataFromApi();
        },
      );
    }
  }

  //*--------------------------------------------------------------
  //* --- Sign up Method ---
  void signUp() async {
    // check if user input is valid
    if (formKeySignup.currentState!.validate()) {
      emit(UserSignUpLoading());

      // send request
      final response = await userRepo.signUp(
        email: emailSignupController.text,
        password: passwordSignupController.text,
        confirmPassword: confirmPasswordSignupController.text,
      );

      // check response and emit state
      response.fold(
        (leftSide) => emit(UserSignUpFailure(errorMessage: leftSide)),
        (rightSide) {
          emit(UserSignUpSuccess());
        },
      );
    }
  }

  //--------------------------------------------------------------
  //* --- Sign out Method ---
  void signOut() async {
    emit(UserSignOutLoading());
    final response = await userRepo.signOut();
    response.fold(
      (leftSide) => emit(UserSignOutFailure(errorMessage: leftSide)),
      (rightSide) => emit(UserSignOutSuccess()),
    );
  }

  //--------------------------------------------------------------
  //* --- Get User Data Method ---
  void getUserDataFromApi() async {
    emit(UserGetDataLoading());
    final response = await userRepo.getUserDataFromApi();
    response.fold(
      (leftSide) => emit(UserGetDataFailure(errorMessage: leftSide)),
      (rightSide) => emit(UserGetDataSuccess(userModel: rightSide)),
    );
  }
}
