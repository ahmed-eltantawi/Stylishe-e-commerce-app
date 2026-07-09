import 'package:bloc/bloc.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState(selectedIndex: 0));

  void selectTab(int index) => emit(NavState(selectedIndex: index));
}
