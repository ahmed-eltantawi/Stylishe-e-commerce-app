import 'package:flutter/material.dart';
import 'package:stylish/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:stylish/features/settings/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.localDataSource});

  final SettingsLocalDataSource localDataSource;

  @override
  ThemeMode getThemeMode() {
    final value = localDataSource.getThemeMode();
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  @override
  void saveThemeMode(ThemeMode mode) => localDataSource.saveThemeMode(mode.name);
}
