// Create a global instance (or use GetIt.instance)
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo_implementation.dart';
import 'package:stylish/features/categories/data/repositories/categories_repo_implementation.dart';
import 'package:stylish/features/home/data/repos/products_repo_impl.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';
import 'package:stylish/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:stylish/features/cart/data/datasources/cart_local_data_source_impl.dart';
import 'package:stylish/features/cart/data/repositories/cart_repo.dart';
import 'package:stylish/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:stylish/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:stylish/features/wishlist/data/datasources/wishlist_local_data_source_impl.dart';
import 'package:stylish/features/wishlist/data/repositories/wishlist_repo.dart';
import 'package:stylish/features/wishlist/data/repositories/wishlist_repo_impl.dart';
import 'package:stylish/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:stylish/features/settings/data/datasources/settings_local_data_source_impl.dart';
import 'package:stylish/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:stylish/features/settings/data/repositories/theme_repository_impl.dart';
import 'package:stylish/features/settings/domain/repositories/settings_repository.dart';
import 'package:stylish/features/settings/domain/repositories/theme_repository.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // all objects you want to use only on time in your app
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  await getIt<CacheHelper>().init();
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioConsumer>(DioConsumer(dio: getIt<Dio>()));

  // ── Auth ────────────────────────────────────────────────────────────────────
  getIt.registerSingleton<AuthRepoImplementation>(
    AuthRepoImplementation(dioConsumer: getIt<DioConsumer>()),
  );

  // ── Home (existing, partial product repo for home feature) ─────────────────
  getIt.registerSingleton<ProductsRepoImpl>(
    ProductsRepoImpl(dioConsumer: getIt<DioConsumer>()),
  );

  // ── Products (full CRUD) ───────────────────────────────────────────────────
  getIt.registerSingleton<ProductsRepoImplementation>(
    ProductsRepoImplementation(dioConsumer: getIt<DioConsumer>()),
  );

  // ── Categories ─────────────────────────────────────────────────────────────
  getIt.registerSingleton<CategoriesRepoImplementation>(
    CategoriesRepoImplementation(dioConsumer: getIt<DioConsumer>()),
  );

  // ── Cart ───────────────────────────────────────────────────────────────────
  getIt.registerSingleton<CartLocalDataSource>(
    CartLocalDataSourceImpl(),
  );
  getIt.registerSingleton<CartRepo>(
    CartRepoImpl(localDataSource: getIt<CartLocalDataSource>()),
  );

  // ── Wishlist ───────────────────────────────────────────────────────────────
  getIt.registerSingleton<WishlistLocalDataSource>(
    WishlistLocalDataSourceImpl(),
  );
  getIt.registerSingleton<WishlistRepo>(
    WishlistRepoImpl(localDataSource: getIt<WishlistLocalDataSource>()),
  );

  // ── Settings ───────────────────────────────────────────────────────────────
  getIt.registerSingleton<SettingsLocalDataSource>(
    SettingsLocalDataSourceImpl(cache: getIt<CacheHelper>()),
  );
  getIt.registerSingleton<ThemeRepository>(
    ThemeRepositoryImpl(localDataSource: getIt<SettingsLocalDataSource>()),
  );
  getIt.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(localDataSource: getIt<SettingsLocalDataSource>()),
  );
}
