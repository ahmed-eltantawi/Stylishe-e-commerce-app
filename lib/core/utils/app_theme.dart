import 'package:flutter/material.dart';
import 'package:stylish/core/theme/dark_theme.dart' as DarkTheme;
import 'package:stylish/core/theme/light_theme.dart' as LightTheme;

abstract class AppTheme {
  static ThemeData get lightTheme => LightTheme.lightTheme;
  static ThemeData get darkTheme => DarkTheme.darkTheme;
}
