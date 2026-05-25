import 'package:flutter/material.dart';
import 'package:stylish/features/Auth/data/models/signup_model.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';
import 'package:stylish/features/Auth/data/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepo}) : super(UserInitial());
  final UserRepo userRepo;

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
    emit(UserSignInLoading());
    final response = await userRepo.singIn(
      email: emailSigninController.text,
      password: passwordSigninController.text,
    );

    response.fold(
      (leftSide) => emit(UserSignInFailure(errorMessage: leftSide)),
      (rightSide) => emit(UserSignInSuccess(model: rightSide)),
    );
  }

  //--------------------------------------------------------------
  //* --- Sign up Method ---
  void signUp() async {
    emit(UserSignUpLoading());
    final response = await userRepo.signUp(
      email: emailSignupController.text,
      password: passwordSignupController.text,
      confirmPassword: confirmPasswordSignupController.text,
    );
    response.fold(
      (leftSide) => emit(UserSignUpFailure(errorMessage: leftSide)),
      (rightSide) => emit(UserSignUpSuccess(model: rightSide)),
    );
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
    final response = await userRepo.getUserDataFromApi();
    response.fold(
      (leftSide) => emit(UserGetDataFailure(errorMessage: leftSide)),
      (rightSide) => emit(UserGetDataSuccess(userModel: rightSide)),
    );
  }
}
