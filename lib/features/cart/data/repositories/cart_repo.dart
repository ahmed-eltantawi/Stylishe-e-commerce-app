import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

abstract class CartRepo {
  Either<Failure, List<CartItem>> getItems();
  Either<Failure, List<CartItem>> addItem(ProductModel product);
  Either<Failure, List<CartItem>> removeItem(int productId);
  Either<Failure, List<CartItem>> updateQuantity(int productId, int quantity);
  Either<Failure, List<CartItem>> clearCart();
}
