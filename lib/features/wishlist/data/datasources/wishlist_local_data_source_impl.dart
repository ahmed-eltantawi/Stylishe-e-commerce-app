import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';

/// In-memory wishlist implementation. Swap for Hive/SharedPrefs without
/// touching the repository or presentation layers.
class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final List<WishlistItem> _items = [];

  @override
  List<WishlistItem> getItems() => List.unmodifiable(_items);

  @override
  void addItem(ProductModel product) {
    if (!contains(product.id.toInt())) {
      _items.add(WishlistItem(product: product));
    }
  }

  @override
  void removeItem(int productId) {
    _items.removeWhere((i) => i.product.id == productId);
  }

  @override
  bool contains(int productId) =>
      _items.any((i) => i.product.id == productId);
}
