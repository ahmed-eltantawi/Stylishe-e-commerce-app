abstract class SettingsLocalDataSource {
  String? getThemeMode();
  void saveThemeMode(String value);
  String? getLanguageCode();
  void saveLanguageCode(String value);
  bool? getNotificationsEnabled();
  void saveNotificationsEnabled(bool value);
}
