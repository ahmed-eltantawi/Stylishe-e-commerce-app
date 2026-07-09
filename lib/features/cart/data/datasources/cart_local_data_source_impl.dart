import 'dart:convert';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  List<CartItem> _items = [];
  bool _initialized = false;

  void _initIfNeeded() {
    if (_initialized) return;
    final data = getIt<CacheHelper>().getString(key: "cached_cart");
    if (data != null && data.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(data);
        _items = decoded
            .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }
    _initialized = true;
  }

  Future<void> _saveToCache() async {
    final encoded = jsonEncode(_items.map((e) => e.toJson()).toList());
    await getIt<CacheHelper>().saveData(key: "cached_cart", value: encoded);
  }

  @override
  List<CartItem> getItems() {
    _initIfNeeded();
    return List.unmodifiable(_items);
  }

  @override
  void addItem(ProductModel product) {
    _initIfNeeded();
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    _saveToCache();
  }

  @override
  void removeItem(int productId) {
    _initIfNeeded();
    _items.removeWhere((i) => i.product.id == productId);
    _saveToCache();
  }

  @override
  void updateQuantity(int productId, int quantity) {
    _initIfNeeded();
    final index = _items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
      _saveToCache();
    }
  }

  @override
  void clearCart() {
    _items.clear();
    _saveToCache();
  }
}
