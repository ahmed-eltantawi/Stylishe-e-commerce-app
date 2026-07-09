import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';
import 'package:stylish/features/categories/data/repositories/categories_repo_implementation.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit({required this.categoriesRepo})
      : super(GetCategoriesInitial());

  final CategoriesRepoImplementation categoriesRepo;

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    final result = await categoriesRepo.getCategories();
    result.fold(
      (failure) =>
          emit(GetCategoriesFailure(errorMessage: failure.errorMessage)),
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );
  }
}
