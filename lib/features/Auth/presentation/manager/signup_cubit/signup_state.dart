part of 'signup_cubit.dart';

//* ============== Sign Up States ==============
@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignUpSuccess extends SignupState {}

final class SignUpFailure extends SignupState {
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}

final class SignUpLoading extends SignupState {}

final class NoInternetConnection extends SignupState {}
