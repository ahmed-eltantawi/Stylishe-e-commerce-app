part of 'nav_cubit.dart';

class NavState {
  final int selectedIndex;

  /// Carries a category title from the Home categories bar into the Search tab.
  /// Consumed once by [_SearchTab] and then cleared.
  final String? pendingCategoryName;

  const NavState({
    required this.selectedIndex,
    this.pendingCategoryName,
  });

  NavState clearPending() =>
      NavState(selectedIndex: selectedIndex, pendingCategoryName: null);
}
