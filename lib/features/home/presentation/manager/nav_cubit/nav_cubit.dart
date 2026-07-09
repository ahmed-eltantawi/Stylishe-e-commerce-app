import 'package:bloc/bloc.dart';

part 'nav_state.dart';

/// Manages the currently selected bottom navigation tab index.
/// Using a Cubit keeps tab state outside of widgets and allows any
/// child route (e.g. ProductDetailsView) to switch tabs without
/// knowing the shell structure.
class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState(selectedIndex: 0));

  void selectTab(int index) =>
      emit(NavState(selectedIndex: index, pendingCategoryName: null));

  /// Switches to [index] (typically 3 = Search) and carries [categoryName]
  /// so the Search tab can pre-populate the search bar and filter results.
  void selectTabWithCategory(int index, String categoryName) =>
      emit(NavState(selectedIndex: index, pendingCategoryName: categoryName));

  /// Called by the Search tab once it has consumed the pending category name.
  void clearPendingCategory() => emit(state.clearPending());
}
