part of 'signin_cubit.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

//* ============== Sign In States ==============
final class SignInSuccess extends SigninState {
  final SignInResponseModel signinModel;
  SignInSuccess({required this.signinModel});
}

final class SignInFailure extends SigninState {
  final String errorMessage;
  SignInFailure({required this.errorMessage});
}

final class NoInternetConnection extends SigninState {}

final class SignInLoading extends SigninState {}
