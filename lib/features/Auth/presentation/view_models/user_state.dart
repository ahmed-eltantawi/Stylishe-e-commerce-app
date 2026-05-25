part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

//* === Sign In States ===
final class UserSignInSuccess extends UserState {}

final class UserSignInFailure extends UserState {
  final String errorMessage;
  UserSignInFailure({required this.errorMessage});
}

final class UserSignInLoading extends UserState {}

//* === Sign Up States ===
final class UserSignUpSuccess extends UserState {}

final class UserSignUpFailure extends UserState {
  final String errorMessage;
  UserSignUpFailure({required this.errorMessage});
}

final class UserSignUpLoading extends UserState {}
