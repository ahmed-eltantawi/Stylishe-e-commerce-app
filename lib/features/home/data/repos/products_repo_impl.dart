import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/core/networking/api_end_points.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/data/repos/products_repo.dart';

class ProductsRepoImpl extends ProductsRepo {
  final DioConsumer dioConsumer;

  ProductsRepoImpl({required this.dioConsumer});
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await dioConsumer.get(
        EndPoint.products,
        queryParameters: {ApiKey.limit: limit, ApiKey.offset: offset},
      );
      final products = (response as List)
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return Right(products);
    } on DioException catch (e) {
      return Left(Failure(errorMessage: e.message!));
    } catch (e) {
      return Left(Failure(errorMessage: "Unexpected error"));
    }
  }
}
