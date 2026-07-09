import 'dart:convert';

import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';
import 'package:stylish/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final CacheHelper _cacheHelper;

  CartLocalDataSourceImpl({required CacheHelper cacheHelper})
      : _cacheHelper = cacheHelper;

  List<CartItem>? _cachedItems;

  List<CartItem> _getItems() {
    if (_cachedItems != null) return _cachedItems!;
    _cachedItems = _loadFromStorage();
    return _cachedItems!;
  }

  List<CartItem> _loadFromStorage() {
    final stored = _cacheHelper.getString(key: CacheKey.cartItems);
    if (stored == null || stored.isEmpty) return [];
    final List<dynamic> decoded = jsonDecode(stored) as List<dynamic>;
    return decoded.map((e) {
      final map = e as Map<String, dynamic>;
      return CartItem(
        product: ProductModel.fromJson(map['product'] as Map<String, dynamic>),
        quantity: map['quantity'] as int,
      );
    }).toList();
  }

  void _persist() {
    final encoded = jsonEncode(
      _cachedItems!.map((e) => {
        'product': e.product.toJson(),
        'quantity': e.quantity,
      }).toList(),
    );
    _cacheHelper.saveData(key: CacheKey.cartItems, value: encoded);
  }

  @override
  List<CartItem> getItems() => List.unmodifiable(_getItems());

  @override
  void addItem(ProductModel product) {
    final items = _getItems();
    final index = items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItem(product: product, quantity: 1));
    }
    _persist();
  }

  @override
  void removeItem(int productId) {
    _getItems().removeWhere((i) => i.product.id == productId);
    _persist();
  }

  @override
  void updateQuantity(int productId, int quantity) {
    final items = _getItems();
    final index = items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index] = items[index].copyWith(quantity: quantity);
      }
    }
    _persist();
  }

  @override
  void clearCart() {
    _getItems().clear();
    _persist();
  }
}
