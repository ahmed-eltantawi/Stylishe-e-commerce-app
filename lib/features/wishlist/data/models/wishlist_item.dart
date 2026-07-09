import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class WishlistItem {
  final ProductModel product;

  const WishlistItem({required this.product});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItem && other.product.id == product.id;

  @override
  int get hashCode => product.id.hashCode;
}
