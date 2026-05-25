// Create a global instance (or use GetIt.instance)
import 'package:get_it/get_it.dart';
import 'package:stylish/core/cache/cache_helper.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // all objects you want to use only on time in your app
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  await getIt<CacheHelper>().init();
}
