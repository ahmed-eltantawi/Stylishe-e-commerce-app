part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalPrice;
  CartLoaded({required this.items, required this.totalPrice});
}

final class CartFailure extends CartState {
  final String message;
  CartFailure({required this.message});
}
