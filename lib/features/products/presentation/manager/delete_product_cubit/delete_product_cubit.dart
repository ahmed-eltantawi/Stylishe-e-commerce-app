import 'package:bloc/bloc.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit({required this.productsRepo})
      : super(DeleteProductInitial());

  final ProductsRepoImplementation productsRepo;

  Future<void> deleteProduct({required int id}) async {
    emit(DeleteProductLoading());
    final result = await productsRepo.deleteProduct(id: id);
    result.fold(
      (failure) =>
          emit(DeleteProductFailure(errorMessage: failure.errorMessage)),
      (_) => emit(DeleteProductSuccess()),
    );
  }
}
