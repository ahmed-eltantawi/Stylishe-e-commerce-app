import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';

/// Abstract contract for wishlist local data operations.
/// Implementations can use in-memory, Hive, or SharedPrefs without touching
/// the repository or presentation layers.
abstract class WishlistLocalDataSource {
  List<WishlistItem> getItems();
  void addItem(ProductModel product);
  void removeItem(int productId);
  bool contains(int productId);
}
