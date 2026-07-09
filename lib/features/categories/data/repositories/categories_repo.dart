import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';

abstract class CategoriesRepo {
  /// Fetches all categories from the API.
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
