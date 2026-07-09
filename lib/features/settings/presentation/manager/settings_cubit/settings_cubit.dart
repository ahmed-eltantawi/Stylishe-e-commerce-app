import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_key.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsLoaded(
    themeMode: ThemeMode.system,
    locale: Locale('en'),
    notificationsEnabled: true,
  )) {
    _load();
  }

  void _load() {
    final cache = getIt<CacheHelper>();
    final themeStr = cache.getString(key: CacheKey.themeMode);
    final langStr = cache.getString(key: CacheKey.languageCode);
    final notif = cache.getBool(key: CacheKey.notificationsEnabled);

    emit(SettingsLoaded(
      themeMode: _parseThemeMode(themeStr),
      locale: Locale(langStr ?? 'en'),
      notificationsEnabled: notif ?? true,
    ));
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode mode) {
    getIt<CacheHelper>().saveData(key: CacheKey.themeMode, value: mode.name);
    emit(SettingsUpdated(
      themeMode: mode,
      locale: state.locale,
      notificationsEnabled: state.notificationsEnabled,
    ));
  }

  void setLocale(Locale locale) {
    getIt<CacheHelper>().saveData(key: CacheKey.languageCode, value: locale.languageCode);
    emit(SettingsUpdated(
      themeMode: state.themeMode,
      locale: locale,
      notificationsEnabled: state.notificationsEnabled,
    ));
  }

  void setNotificationsEnabled(bool enabled) {
    getIt<CacheHelper>().saveData(key: CacheKey.notificationsEnabled, value: enabled);
    emit(SettingsUpdated(
      themeMode: state.themeMode,
      locale: state.locale,
      notificationsEnabled: enabled,
    ));
  }
}
