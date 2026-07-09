import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';
import 'package:stylish/features/settings/data/datasources/settings_local_data_source.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl({required this.cache});

  final CacheHelper cache;

  @override
  String? getThemeMode() => cache.getString(key: CacheKey.themeMode);

  @override
  void saveThemeMode(String value) => cache.saveData(key: CacheKey.themeMode, value: value);

  @override
  String? getLanguageCode() => cache.getString(key: CacheKey.languageCode);

  @override
  void saveLanguageCode(String value) => cache.saveData(key: CacheKey.languageCode, value: value);

  @override
  bool? getNotificationsEnabled() => cache.getBool(key: CacheKey.notificationsEnabled);

  @override
  void saveNotificationsEnabled(bool value) => cache.saveData(key: CacheKey.notificationsEnabled, value: value);
}
