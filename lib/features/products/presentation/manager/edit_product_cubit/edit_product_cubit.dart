import 'package:bloc/bloc.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/data/models/create_product_request.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit({required this.productsRepo}) : super(EditProductInitial());

  final ProductsRepoImplementation productsRepo;

  Future<void> editProduct({
    required int id,
    required CreateProductRequest request,
  }) async {
    emit(EditProductLoading());
    final result =
        await productsRepo.updateProduct(id: id, request: request);
    result.fold(
      (failure) =>
          emit(EditProductFailure(errorMessage: failure.errorMessage)),
      (product) => emit(EditProductSuccess(product: product)),
    );
  }
}
