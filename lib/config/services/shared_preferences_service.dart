import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';

abstract class SharedPreferencesService {
  static Future<void> setLoggedIn(bool value) async {
    await getIt<CacheHelper>().saveData(key: CacheKey.isLoggedIn, value: value);
  }

  static Future<bool> getLoggedIn() async {
    return await getIt<CacheHelper>().getData(key: CacheKey.isLoggedIn) ??
        false;
  }

  static Future<void> clearAuthData() async {
    await getIt<CacheHelper>().deleteData(key: CacheKey.isLoggedIn);
  }

  static Future<void> onBoardingViewed() async {
    await getIt<CacheHelper>().saveData(
      key: CacheKey.onBoardingViewed,
      value: true,
    );
  }

  static bool isOnBoardingViewed() {
    return getIt<CacheHelper>().getData(key: CacheKey.onBoardingViewed) ??
        false;
  }
}
