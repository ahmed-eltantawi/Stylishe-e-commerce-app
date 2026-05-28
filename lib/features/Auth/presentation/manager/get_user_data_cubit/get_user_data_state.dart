part of 'get_user_data_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

//* ============== Get User Data States ==============
final class UserGetDataSuccess extends UserState {
  final UserModel userModel;
  UserGetDataSuccess({required this.userModel});
}

final class UserGetDataFailure extends UserState {
  final String errorMessage;
  UserGetDataFailure({required this.errorMessage});
}

final class UserGetDataLoading extends UserState {}

final class NoInternetConnection extends UserState {}
