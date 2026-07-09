import 'package:stylish/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

/// In-memory implementation. Swap this for Hive/SharedPrefs without touching
/// the repository or presentation layers.
class CartLocalDataSourceImpl implements CartLocalDataSource {
  final List<CartItem> _items = [];

  @override
  List<CartItem> getItems() => List.unmodifiable(_items);

  @override
  void addItem(ProductModel product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: _items[index].quantity + 1);
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
  }

  @override
  void removeItem(int productId) {
    _items.removeWhere((i) => i.product.id == productId);
  }

  @override
  void updateQuantity(int productId, int quantity) {
    final index = _items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
    }
  }

  @override
  void clearCart() => _items.clear();
}
