import 'package:bloc/bloc.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this.productsRepo})
      : super(ProductDetailsInitial());

  final ProductsRepoImplementation productsRepo;

  Future<void> getProductDetails({required int id}) async {
    emit(ProductDetailsLoading());
    final result = await productsRepo.getProductById(id: id);
    result.fold(
      (failure) =>
          emit(ProductDetailsFailure(errorMessage: failure.errorMessage)),
      (product) => emit(ProductDetailsSuccess(product: product)),
    );
  }
}
