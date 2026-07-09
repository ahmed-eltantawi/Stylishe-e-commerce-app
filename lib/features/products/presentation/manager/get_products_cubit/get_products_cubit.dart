import 'package:bloc/bloc.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit({required this.productsRepo}) : super(GetProductsInitial());

  final ProductsRepoImplementation productsRepo;

  static const int _limit = 10;
  int _offset = 0;
  bool _hasMore = true;
  bool _isFetching = false;
  int? _activeCategoryId;
  String? _activeTitle;

  final List<ProductModel> _currentProducts = [];

  List<ProductModel> get currentProducts => List.unmodifiable(_currentProducts);

  /// First load — resets everything and fetches fresh.
  Future<void> fetchProducts({int? categoryId, String? title}) async {
    if (_isFetching) return;
    _reset(categoryId: categoryId, title: title);
    emit(GetProductsLoading());

    final result = await productsRepo.getProducts(
      limit: _limit,
      offset: _offset,
      categoryId: _activeCategoryId,
      title: _activeTitle,
    );

    _isFetching = false;

    result.fold(
      (failure) =>
          emit(GetProductsFailure(errorMessage: failure.errorMessage)),
      (products) {
        _currentProducts.addAll(products);
        _hasMore = products.length >= _limit;
        _offset += products.length;
        emit(GetProductsSuccess(
          products: List.from(_currentProducts),
          hasMore: _hasMore,
        ));
      },
    );
  }

  /// Subsequent pages — appends to current list.
  Future<void> fetchMoreProducts() async {
    if (!_hasMore || _isFetching) return;
    _isFetching = true;
    emit(GetProductsPaginationLoading(
        currentProducts: List.from(_currentProducts)));

    final result = await productsRepo.getProducts(
      limit: _limit,
      offset: _offset,
      categoryId: _activeCategoryId,
      title: _activeTitle,
    );

    _isFetching = false;

    result.fold(
      (failure) => emit(GetProductsPaginationFailure(
        currentProducts: List.from(_currentProducts),
        errorMessage: failure.errorMessage,
      )),
      (products) {
        _currentProducts.addAll(products);
        _hasMore = products.length >= _limit;
        _offset += products.length;
        emit(GetProductsSuccess(
          products: List.from(_currentProducts),
          hasMore: _hasMore,
        ));
      },
    );
  }

  void _reset({int? categoryId, String? title}) {
    _offset = 0;
    _hasMore = true;
    _isFetching = true;
    _activeCategoryId = categoryId;
    _activeTitle = title;
    _currentProducts.clear();
  }
}
