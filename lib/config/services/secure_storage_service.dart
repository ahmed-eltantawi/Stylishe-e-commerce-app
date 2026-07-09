import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';

abstract class SecureStorageService {
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await getIt<CacheHelper>().saveData(
      key: CacheKey.accessToken,
      value: accessToken,
    );
    await getIt<CacheHelper>().saveData(
      key: CacheKey.refreshToken,
      value: refreshToken,
    );
  }

  // --- Get access token ---
  static Future<String?> getAccessToken() async {
    return getIt<CacheHelper>().getString(key: CacheKey.accessToken);
  }

  // --- Get refresh token ---

  static Future<String?> getRefreshToken() async {
    return getIt<CacheHelper>().getString(key: CacheKey.refreshToken);
  }

  // --- Delete access token and refresh token ---
  static Future<void> deleteTokens() async {
    await getIt<CacheHelper>().deleteData(key: CacheKey.accessToken);
    await getIt<CacheHelper>().deleteData(key: CacheKey.refreshToken);
  }
}
