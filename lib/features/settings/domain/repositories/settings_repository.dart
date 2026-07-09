import 'dart:ui';

abstract class SettingsRepository {
  Locale getLocale();
  void saveLocale(Locale locale);
  bool getNotificationsEnabled();
  void saveNotificationsEnabled(bool enabled);
}
