import 'package:bloc/bloc.dart';
import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/cart/data/repositories/cart_repo.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/core/utils/pricing_utils.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartRepo}) : super(CartInitial());

  final CartRepo cartRepo;

  void loadCart() {
    cartRepo.getItems().fold(
      (failure) => emit(CartFailure(message: failure.errorMessage)),
      (items) => emit(CartLoaded(items: items, totalPrice: _calcTotal(items))),
    );
  }

  void addItem(ProductModel product) {
    cartRepo.addItem(product).fold(
      (failure) => emit(CartFailure(message: failure.errorMessage)),
      (items) => emit(CartLoaded(items: items, totalPrice: _calcTotal(items))),
    );
  }

  void removeItem(int productId) {
    cartRepo.removeItem(productId).fold(
      (failure) => emit(CartFailure(message: failure.errorMessage)),
      (items) => emit(CartLoaded(items: items, totalPrice: _calcTotal(items))),
    );
  }

  void updateQuantity(int productId, int quantity) {
    cartRepo.updateQuantity(productId, quantity).fold(
      (failure) => emit(CartFailure(message: failure.errorMessage)),
      (items) => emit(CartLoaded(items: items, totalPrice: _calcTotal(items))),
    );
  }

  void clearCart() {
    cartRepo.clearCart().fold(
      (failure) => emit(CartFailure(message: failure.errorMessage)),
      (items) => emit(CartLoaded(items: items, totalPrice: _calcTotal(items))),
    );
  }

  double _calcTotal(List<CartItem> items) =>
      items.fold(0, (sum, item) => sum + PricingUtils.discountedPrice(item.product.price) * item.quantity);
}
