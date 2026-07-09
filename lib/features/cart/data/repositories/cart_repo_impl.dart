import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/cart/data/repositories/cart_repo.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class CartRepoImpl implements CartRepo {
  CartRepoImpl({required this.localDataSource});
  final CartLocalDataSource localDataSource;

  @override
  Either<Failure, List<CartItem>> getItems() {
    try {
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<CartItem>> addItem(ProductModel product) {
    try {
      localDataSource.addItem(product);
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<CartItem>> removeItem(int productId) {
    try {
      localDataSource.removeItem(productId);
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<CartItem>> updateQuantity(int productId, int quantity) {
    try {
      localDataSource.updateQuantity(productId, quantity);
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<CartItem>> clearCart() {
    try {
      localDataSource.clearCart();
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
