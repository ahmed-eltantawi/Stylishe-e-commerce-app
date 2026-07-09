// TODO: consider extracting ProductModel to a shared/core model if more features need it
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

  double get totalPrice => (product.price * quantity).toDouble();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem && other.product.id == product.id;

  @override
  int get hashCode => product.id.hashCode;
}
