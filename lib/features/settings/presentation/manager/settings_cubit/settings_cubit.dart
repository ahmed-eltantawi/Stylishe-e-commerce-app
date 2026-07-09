import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:stylish/features/settings/domain/repositories/settings_repository.dart';
import 'package:stylish/features/settings/domain/repositories/theme_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required this.themeRepository,
    required this.settingsRepository,
  }) : super(const SettingsLoaded(
    themeMode: ThemeMode.system,
    locale: Locale('en'),
    notificationsEnabled: true,
  )) {
    _load();
  }

  final ThemeRepository themeRepository;
  final SettingsRepository settingsRepository;

  void _load() {
    emit(SettingsLoaded(
      themeMode: themeRepository.getThemeMode(),
      locale: settingsRepository.getLocale(),
      notificationsEnabled: settingsRepository.getNotificationsEnabled(),
    ));
  }

  void setThemeMode(ThemeMode mode) {
    themeRepository.saveThemeMode(mode);
    emit(SettingsUpdated(
      themeMode: mode,
      locale: state.locale,
      notificationsEnabled: state.notificationsEnabled,
    ));
  }

  void setLocale(Locale locale) {
    settingsRepository.saveLocale(locale);
    emit(SettingsUpdated(
      themeMode: state.themeMode,
      locale: locale,
      notificationsEnabled: state.notificationsEnabled,
    ));
  }

  void setNotificationsEnabled(bool enabled) {
    settingsRepository.saveNotificationsEnabled(enabled);
    emit(SettingsUpdated(
      themeMode: state.themeMode,
      locale: state.locale,
      notificationsEnabled: enabled,
    ));
  }
}
