import 'package:bloc/bloc.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';
import 'package:stylish/features/wishlist/data/repositories/wishlist_repo.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({required this.wishlistRepo}) : super(WishlistInitial());

  final WishlistRepo wishlistRepo;

  void loadWishlist() {
    wishlistRepo.getItems().fold(
      (failure) => emit(WishlistFailure(message: failure.errorMessage)),
      (items) => emit(WishlistLoaded(items: items)),
    );
  }

  /// Adds or removes the product depending on whether it is already in the list.
  void toggle(ProductModel product) {
    final id = product.id.toInt();
    wishlistRepo.contains(id).fold(
      (failure) => emit(WishlistFailure(message: failure.errorMessage)),
      (isIn) {
        if (isIn) {
          _remove(id);
        } else {
          _add(product);
        }
      },
    );
  }

  bool isInWishlist(int productId) {
    final state = this.state;
    if (state is WishlistLoaded) {
      return state.items.any((i) => i.product.id == productId);
    }
    return false;
  }

  void _add(ProductModel product) {
    wishlistRepo.addItem(product).fold(
      (failure) => emit(WishlistFailure(message: failure.errorMessage)),
      (items) => emit(WishlistLoaded(items: items)),
    );
  }

  void _remove(int productId) {
    wishlistRepo.removeItem(productId).fold(
      (failure) => emit(WishlistFailure(message: failure.errorMessage)),
      (items) => emit(WishlistLoaded(items: items)),
    );
  }
}
