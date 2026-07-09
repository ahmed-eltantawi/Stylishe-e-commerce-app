import 'dart:convert';

import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final CacheHelper _cacheHelper;

  WishlistLocalDataSourceImpl({required CacheHelper cacheHelper})
      : _cacheHelper = cacheHelper;

  List<WishlistItem>? _cachedItems;

  List<WishlistItem> _getItems() {
    if (_cachedItems != null) return _cachedItems!;
    _cachedItems = _loadFromStorage();
    return _cachedItems!;
  }

  List<WishlistItem> _loadFromStorage() {
    final stored = _cacheHelper.getString(key: CacheKey.wishlistItems);
    if (stored == null || stored.isEmpty) return [];
    final List<dynamic> decoded = jsonDecode(stored) as List<dynamic>;
    return decoded.map((e) {
      return WishlistItem(
        product: ProductModel.fromJson(e as Map<String, dynamic>),
      );
    }).toList();
  }

  void _persist() {
    final encoded = jsonEncode(
      _cachedItems!.map((e) => e.product.toJson()).toList(),
    );
    _cacheHelper.saveData(key: CacheKey.wishlistItems, value: encoded);
  }

  @override
  List<WishlistItem> getItems() => List.unmodifiable(_getItems());

  @override
  void addItem(ProductModel product) {
    if (!contains(product.id.toInt())) {
      _getItems().add(WishlistItem(product: product));
    }
    _persist();
  }

  @override
  void removeItem(int productId) {
    _getItems().removeWhere((i) => i.product.id == productId);
    _persist();
  }

  @override
  bool contains(int productId) =>
      _getItems().any((i) => i.product.id == productId);
}
