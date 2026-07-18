part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductModel> products; // the old and the new products
  final bool hasMore;
  ProductsSuccess({required this.products, required this.hasMore});
}

final class ProductsFailure extends ProductsState {
  final String errorMessage;

  ProductsFailure({required this.errorMessage});
}

//* ======= Pagination states =========
final class ProductsPaginationFailure extends ProductsState {
  final String errorMessage;
  final List<ProductModel> currentProducts;
  ProductsPaginationFailure({
    required this.errorMessage,
    required this.currentProducts,
  });
}

final class ProductsPaginationLoading extends ProductsState {
  final List<ProductModel> currentProducts;

  ProductsPaginationLoading({required this.currentProducts});
}
