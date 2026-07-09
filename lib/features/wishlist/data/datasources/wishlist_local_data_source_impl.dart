import 'dart:convert';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  List<WishlistItem> _items = [];
  bool _initialized = false;

  void _initIfNeeded() {
    if (_initialized) return;
    final data = getIt<CacheHelper>().getString(key: "cached_wishlist");
    if (data != null && data.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(data);
        _items = decoded
            .map((e) => WishlistItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }
    _initialized = true;
  }

  Future<void> _saveToCache() async {
    final encoded = jsonEncode(_items.map((e) => e.toJson()).toList());
    await getIt<CacheHelper>().saveData(key: "cached_wishlist", value: encoded);
  }

  @override
  List<WishlistItem> getItems() {
    _initIfNeeded();
    return List.unmodifiable(_items);
  }

  @override
  void addItem(ProductModel product) {
    _initIfNeeded();
    if (!contains(product.id.toInt())) {
      _items.add(WishlistItem(product: product));
      _saveToCache();
    }
  }

  @override
  void removeItem(int productId) {
    _initIfNeeded();
    _items.removeWhere((i) => i.product.id == productId);
    _saveToCache();
  }

  @override
  bool contains(int productId) {
    _initIfNeeded();
    return _items.any((i) => i.product.id == productId);
  }
}
