import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/failure.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/data/models/create_product_request.dart';

abstract class ProductsRepo {
  /// Get a paginated list of products with optional filters.
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required int limit,
    required int offset,
    int? categoryId,
    String? title,
  });

  /// Get a single product by ID.
  Future<Either<Failure, ProductModel>> getProductById({required int id});

  /// Create a new product (requires auth).
  Future<Either<Failure, ProductModel>> createProduct({
    required CreateProductRequest request,
  });

  /// Update an existing product (requires auth).
  Future<Either<Failure, ProductModel>> updateProduct({
    required int id,
    required CreateProductRequest request,
  });

  /// Delete a product by ID (requires auth).
  Future<Either<Failure, bool>> deleteProduct({required int id});

  /// Get products belonging to a specific category.
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory({
    required int categoryId,
    int limit = 10,
    int offset = 0,
  });
}
