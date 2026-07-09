import 'package:bloc/bloc.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/data/models/create_product_request.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit({required this.productsRepo}) : super(AddProductInitial());

  final ProductsRepoImplementation productsRepo;

  Future<void> addProduct({required CreateProductRequest request}) async {
    emit(AddProductLoading());
    final result = await productsRepo.createProduct(request: request);
    result.fold(
      (failure) => emit(AddProductFailure(errorMessage: failure.errorMessage)),
      (product) => emit(AddProductSuccess(product: product)),
    );
  }
}
