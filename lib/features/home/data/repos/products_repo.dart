import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required int limit,
    required int offset,
  });
}
