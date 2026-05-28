part of 'log_out_cubit.dart';

@immutable
sealed class LogOutState {}

final class LogOutInitial extends LogOutState {}

//* ============== Sign Out States ==============
final class UserSignOutSuccess extends LogOutState {}

final class UserSignOutFailure extends LogOutState {
  final String errorMessage;
  UserSignOutFailure({required this.errorMessage});
}

final class UserSignOutLoading extends LogOutState {}
