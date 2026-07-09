part of 'get_products_cubit.dart';

sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}

final class GetProductsSuccess extends GetProductsState {
  final List<ProductModel> products;
  final bool hasMore;
  GetProductsSuccess({required this.products, required this.hasMore});
}

final class GetProductsFailure extends GetProductsState {
  final String errorMessage;
  GetProductsFailure({required this.errorMessage});
}

final class GetProductsPaginationLoading extends GetProductsState {
  final List<ProductModel> currentProducts;
  GetProductsPaginationLoading({required this.currentProducts});
}

final class GetProductsPaginationFailure extends GetProductsState {
  final List<ProductModel> currentProducts;
  final String errorMessage;
  GetProductsPaginationFailure({
    required this.currentProducts,
    required this.errorMessage,
  });
}
