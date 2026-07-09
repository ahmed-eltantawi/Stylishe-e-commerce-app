part of 'edit_product_cubit.dart';

sealed class EditProductState {}

final class EditProductInitial extends EditProductState {}

final class EditProductLoading extends EditProductState {}

final class EditProductSuccess extends EditProductState {
  final ProductModel product;
  EditProductSuccess({required this.product});
}

final class EditProductFailure extends EditProductState {
  final String errorMessage;
  EditProductFailure({required this.errorMessage});
}
