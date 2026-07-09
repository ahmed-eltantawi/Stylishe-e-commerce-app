import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';

abstract class WishlistRepo {
  Either<Failure, List<WishlistItem>> getItems();
  Either<Failure, List<WishlistItem>> addItem(ProductModel product);
  Either<Failure, List<WishlistItem>> removeItem(int productId);
  Either<Failure, bool> contains(int productId);
}
