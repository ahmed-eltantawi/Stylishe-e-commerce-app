import 'package:flutter/material.dart';
import 'package:stylish/features/Auth/data/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepo}) : super(UserInitial());
  final UserRepo userRepo;

  //? ======================= Controllers ==============================
  // --- Sign in Controllers ---
  TextEditingController emailSigninController = TextEditingController();
  TextEditingController passwordSigninController = TextEditingController();
  GlobalKey<FormState> formKeySignin = GlobalKey<FormState>();

  // --- Sign up Controllers ---
  TextEditingController emailSignupController = TextEditingController();
  TextEditingController passwordSignupController = TextEditingController();
  TextEditingController confirmPasswordSignupController =
      TextEditingController();
  GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();

  //?========================= Methods =========================
  // --- Sign in Method ---
  void signIn() {}
}
