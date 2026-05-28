import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/features/Auth/data/models/user_model.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo_implementation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<UserState> {
  GetUserDataCubit({required this.authRepo}) : super(UserInitial());
  final AuthRepoImplementation authRepo;

  //* --- Get User Data Method ---
  void getUserData() async {
    emit(UserGetDataLoading());
    final response = await authRepo.getUserData();
    response.fold((leftSide) {
      if (leftSide == AppConstants.noInternetConnection) {
        emit(NoInternetConnection());
      } else {
        emit(UserGetDataFailure(errorMessage: leftSide));
      }
    }, (rightSide) => emit(UserGetDataSuccess(userModel: rightSide)));
  }
}
