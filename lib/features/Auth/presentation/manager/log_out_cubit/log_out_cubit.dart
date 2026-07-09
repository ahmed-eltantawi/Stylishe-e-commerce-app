import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo_implementation.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  final AuthRepoImplementation authRepo;
  LogOutCubit({required this.authRepo}) : super(LogOutInitial());

  //* --- Sign out Method ---
  void signOut() async {
    emit(UserSignOutLoading());
    final response = await authRepo.signOut();
    response.fold(
      (leftSide) =>
          emit(UserSignOutFailure(errorMessage: leftSide.errorMessage)),
      (rightSide) => emit(UserSignOutSuccess()),
    );
  }
}
