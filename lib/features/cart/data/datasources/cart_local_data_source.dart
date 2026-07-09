import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

/// Abstract contract for cart local data operations.
/// Implementations can use in-memory, Hive, or SharedPrefs with no changes upstream.
abstract class CartLocalDataSource {
  List<CartItem> getItems();
  void addItem(ProductModel product);
  void removeItem(int productId);
  void updateQuantity(int productId, int quantity);
  void clearCart();
}
