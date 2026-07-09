import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class WishlistItem {
  final ProductModel product;

  const WishlistItem({required this.product});

  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      WishlistItem(product: ProductModel.fromJson(json['product'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItem && other.product.id == product.id;

  @override
  int get hashCode => product.id.hashCode;
}
