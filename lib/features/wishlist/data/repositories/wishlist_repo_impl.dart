import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';
import 'package:stylish/features/wishlist/data/repositories/wishlist_repo.dart';

class WishlistRepoImpl implements WishlistRepo {
  WishlistRepoImpl({required this.localDataSource});
  final WishlistLocalDataSource localDataSource;

  @override
  Either<Failure, List<WishlistItem>> getItems() {
    try {
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<WishlistItem>> addItem(ProductModel product) {
    try {
      localDataSource.addItem(product);
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<WishlistItem>> removeItem(int productId) {
    try {
      localDataSource.removeItem(productId);
      return Right(localDataSource.getItems());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Either<Failure, bool> contains(int productId) {
    try {
      return Right(localDataSource.contains(productId));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
