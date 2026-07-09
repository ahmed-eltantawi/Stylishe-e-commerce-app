part of 'add_product_cubit.dart';

sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final ProductModel product;
  AddProductSuccess({required this.product});
}

final class AddProductFailure extends AddProductState {
  final String errorMessage;
  AddProductFailure({required this.errorMessage});
}
