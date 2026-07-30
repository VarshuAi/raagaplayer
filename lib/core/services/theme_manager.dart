import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ThemeManager {
  ThemeManager._();

  static ThemeData getThemeData(String themeModeKey) {
    switch (themeModeKey) {
      case 'amoled':
        return AppTheme.amoled;
      case 'contrast':
        return AppTheme.highContrast;
      case 'dark':
      default:
        return AppTheme.dark;
    }
  }
}
