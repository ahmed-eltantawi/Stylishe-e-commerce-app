import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/data/repos/products_repo_impl.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.productsRepoImpl}) : super(ProductsInitial());

  final ProductsRepoImpl productsRepoImpl;

  // it's variables to handle the pagination
  static const int _limit = 10;
  int _offset = 0;
  bool _hasMore = true;
  bool _isFetching = false;

  final List<ProductModel> _currentProducts = [];

  /// This is the first calling of the data, it just called once
  Future<void> fetchProducts() async {
    // check if the data is already fetching (loading)
    if (_isFetching) return;

    // reset data
    _reset();
    emit(ProductsLoading());

    // fetch Products data from API
    final result = await productsRepoImpl.getProducts(
      limit: _limit,
      offset: _offset,
    );

    // update state in case of success or failure
    result.fold(
      (failure) => emit(ProductsFailure(errorMessage: failure.errorMessage)),
      (products) {
        // add products to the list
        _currentProducts.addAll(products);

        // update the variables for pagination
        _hasMore = result.length() < _limit;
        _offset += result.length();

        // update the state
        emit(ProductsSuccess(products: products, hasMore: _hasMore));
      },
    );

    // update fetching state
    _isFetching = false;
  }

  int number = 0;

  ///* This is the every calling of the data except the first time
  Future<void> fetchMoreProducts() async {
    log("0.0");
    log("has more: $_hasMore");
    log("is fetching$_isFetching");
    if (!_hasMore || _isFetching) return;
    number++;
    log("number is $number");
    log("0.1");
    // update fetching state
    _isFetching = true;
    emit(ProductsPaginationLoading(currentProducts: _currentProducts));
    log("0.2");
    // fetch Products data from API
    log("offset is $_offset");
    final result = await productsRepoImpl.getProducts(
      limit: _limit,
      offset: _offset,
    );
    log("0.3");
    // update state in case of success or failure
    result.fold(
      (failure) => emit(
        ProductsPaginationFailure(
          currentProducts: _currentProducts,
          errorMessage: failure.errorMessage,
        ),
      ),
      (products) {
        log("0.4");
        // add products to the list
        _currentProducts.addAll(products);
        log("0.5");
        log(
          "products length is ${products.length} offset is $_offset so total is ${products.length + _offset}",
        );
        // update the variables for pagination
        _hasMore = result.length() < _limit;
        _offset += result.length();
        emit(ProductsSuccess(products: products, hasMore: _hasMore));
        log("0.6");
      },
    );
    log("0.7");
    // update fetching state
    _isFetching = false;
    log("is Feching be false");
  }

  /// this method called once when the first fetching of product
  /// it make sure the all data is cleared like the list is empty, the offset is zero
  void _reset() {
    log("reset");
    _offset = 0;
    _hasMore = true;
    _isFetching = true;
    _currentProducts.clear();
  }
}
