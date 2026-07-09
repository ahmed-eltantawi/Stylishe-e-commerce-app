import 'dart:ui';
import 'package:stylish/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:stylish/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required this.localDataSource});

  final SettingsLocalDataSource localDataSource;

  @override
  Locale getLocale() {
    final code = localDataSource.getLanguageCode();
    return Locale(code ?? 'en');
  }

  @override
  void saveLocale(Locale locale) => localDataSource.saveLanguageCode(locale.languageCode);

  @override
  bool getNotificationsEnabled() => localDataSource.getNotificationsEnabled() ?? true;

  @override
  void saveNotificationsEnabled(bool enabled) => localDataSource.saveNotificationsEnabled(enabled);
}
