import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:stylish/core/errors/exceptions.dart';
import 'package:stylish/core/errors/failure.dart';
import 'package:stylish/core/networking/api_end_points.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/core/utils/app_constants.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/data/models/create_product_request.dart';
import 'package:stylish/features/products/data/repositories/products_repo.dart';

class ProductsRepoImplementation extends ProductsRepo {
  ProductsRepoImplementation({required this.dioConsumer});
  final DioConsumer dioConsumer;

  // ─── GET PRODUCTS (paginated + filtered) ────────────────────────────────────
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required int limit,
    required int offset,
    int? categoryId,
    String? title,
  }) async {
    if (!await _isConnected()) {
      return const Left(Failure(errorMessage: AppConstants.noInternetConnection));
    }
    try {
      final Map<String, dynamic> params = {
        ApiKey.limit: limit,
        ApiKey.offset: offset,
        if (categoryId != null) ApiKey.categoryIdFilter: categoryId,
        if (title != null && title.isNotEmpty) ApiKey.titleFilter: title,
      };

      final response = await dioConsumer.get(
        EndPoint.products,
        queryParameters: params,
      );

      final List<ProductModel> products =
          List<Map<String, dynamic>>.from(response as List)
              .map(ProductModel.fromJson)
              .toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: _safeError(e)));
    }
  }

  // ─── GET SINGLE PRODUCT ────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ProductModel>> getProductById({required int id}) async {
    if (!await _isConnected()) {
      return const Left(Failure(errorMessage: AppConstants.noInternetConnection));
    }
    try {
      final response =
          await dioConsumer.get(EndPoint.getProduct(id: id));
      return Right(ProductModel.fromJson(response as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: _safeError(e)));
    }
  }

  // ─── CREATE PRODUCT ────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ProductModel>> createProduct({
    required CreateProductRequest request,
  }) async {
    if (!await _isConnected()) {
      return const Left(Failure(errorMessage: AppConstants.noInternetConnection));
    }
    try {
      final response = await dioConsumer.post(
        EndPoint.products,
        data: request.toJson(),
      );
      return Right(ProductModel.fromJson(response as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: _safeError(e)));
    }
  }

  // ─── UPDATE PRODUCT ────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ProductModel>> updateProduct({
    required int id,
    required CreateProductRequest request,
  }) async {
    if (!await _isConnected()) {
      return const Left(Failure(errorMessage: AppConstants.noInternetConnection));
    }
    try {
      final response = await dioConsumer.put(
        EndPoint.updateProduct(id: id),
        data: request.toJson(),
      );
      return Right(ProductModel.fromJson(response as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: _safeError(e)));
    }
  }

  // ─── DELETE PRODUCT ────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, bool>> deleteProduct({required int id}) async {
    if (!await _isConnected()) {
      return const Left(Failure(errorMessage: AppConstants.noInternetConnection));
    }
    try {
      final response =
          await dioConsumer.delete(EndPoint.deleteProduct(id: id));
      // API returns true on success
      return Right(response == true);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: _safeError(e)));
    }
  }

  // ─── GET PRODUCTS BY CATEGORY ──────────────────────────────────────────────
  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory({
    required int categoryId,
    int limit = 10,
    int offset = 0,
  }) async {
    if (!await _isConnected()) {
      return const Left(Failure(errorMessage: AppConstants.noInternetConnection));
    }
    try {
      final response = await dioConsumer.get(
        EndPoint.getProductsByCategory(categoryId: categoryId),
        queryParameters: {ApiKey.limit: limit, ApiKey.offset: offset},
      );
      final List<ProductModel> products =
          List<Map<String, dynamic>>.from(response as List)
              .map(ProductModel.fromJson)
              .toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errorMessage: _safeError(e)));
    }
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────
  Future<bool> _isConnected() async =>
      await InternetConnection().hasInternetAccess;

  /// Defensive null-check: avoids crashing when DioException has null response.
  /// Core networking exceptions.dart is NOT modified — this is scoped to this repo.
  String _safeError(Object e) {
    if (e is ServerException) return e.errorModel.errorMessage;
    return e.toString();
  }
}
