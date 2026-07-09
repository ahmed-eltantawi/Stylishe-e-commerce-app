part of 'wishlist_cubit.dart';

sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final List<WishlistItem> items;
  WishlistLoaded({required this.items});
}

final class WishlistFailure extends WishlistState {
  final String message;
  WishlistFailure({required this.message});
}
