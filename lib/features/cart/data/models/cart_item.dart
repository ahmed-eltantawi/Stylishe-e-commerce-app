import 'package:stylish/core/utils/pricing_utils.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductModel? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice =>
      PricingUtils.discountedPrice(product.price) * quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem && other.product.id == product.id;

  @override
  int get hashCode => product.id.hashCode;
}
