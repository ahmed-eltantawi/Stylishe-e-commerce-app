part of 'settings_cubit.dart';

sealed class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;
  final bool notificationsEnabled;

  const SettingsState({
    required this.themeMode,
    required this.locale,
    required this.notificationsEnabled,
  });
}

final class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required super.themeMode,
    required super.locale,
    required super.notificationsEnabled,
  });
}

final class SettingsUpdated extends SettingsState {
  const SettingsUpdated({
    required super.themeMode,
    required super.locale,
    required super.notificationsEnabled,
  });
}
