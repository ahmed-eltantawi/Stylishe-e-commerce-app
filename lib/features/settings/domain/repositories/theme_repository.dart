import 'package:flutter/material.dart';

abstract class ThemeRepository {
  ThemeMode getThemeMode();
  void saveThemeMode(ThemeMode mode);
}
