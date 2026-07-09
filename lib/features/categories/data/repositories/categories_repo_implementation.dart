import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:stylish/core/errors/exceptions.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/core/networking/api_end_points.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';
import 'package:stylish/features/categories/data/repositories/categories_repo.dart';

class CategoriesRepoImplementation extends CategoriesRepo {
  CategoriesRepoImplementation({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    if (!await _isConnectedToInternet()) {
      return const Left(Failure(errorMessage: AppConstants.noInternetConnection));
    }
    try {
      final response = await dioConsumer.get(EndPoint.categories);
      final List<CategoryModel> categories =
          List<Map<String, dynamic>>.from(response)
              .map(CategoryModel.fromJson)
              .toList();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  Future<bool> _isConnectedToInternet() async =>
      await InternetConnection().hasInternetAccess;
}
