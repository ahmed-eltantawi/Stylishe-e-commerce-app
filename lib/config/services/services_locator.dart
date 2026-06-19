// Create a global instance (or use GetIt.instance)
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo_implementation.dart';
import 'package:stylish/features/home/data/repos/products_repo_impl.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // all objects you want to use only on time in your app
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  await getIt<CacheHelper>().init();
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<AuthRepoImplementation>(
    AuthRepoImplementation(dioConsumer: DioConsumer(dio: getIt<Dio>())),
  );
  getIt.registerSingleton<ProductsRepoImpl>(
    ProductsRepoImpl(dioConsumer: DioConsumer(dio: getIt<Dio>())),
  );
}
