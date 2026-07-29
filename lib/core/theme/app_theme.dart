import 'package:flutter/material.dart';
import '../design_tokens/radius.dart';
import '../design_tokens/spacing.dart';
import 'app_typography.dart';
import 'presets/dark.dart';
import 'presets/amoled.dart';
import 'presets/high_contrast.dart';

class AppTheme {
  AppTheme._();

  static ThemeData buildTheme(ColorScheme colorScheme, ThemeExtension extension) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      
      // Text Theme mapping
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(color: colorScheme.onSurface),
        displayMedium: AppTypography.displayMedium.copyWith(color: colorScheme.onSurface),
        displaySmall: AppTypography.displaySmall.copyWith(color: colorScheme.onSurface),
        headlineLarge: AppTypography.headlineLarge.copyWith(color: colorScheme.onSurface),
        headlineMedium: AppTypography.headlineMedium.copyWith(color: colorScheme.onSurface),
        headlineSmall: AppTypography.headlineSmall.copyWith(color: colorScheme.onSurface),
        titleLarge: AppTypography.titleLarge.copyWith(color: colorScheme.onSurface),
        titleMedium: AppTypography.titleMedium.copyWith(color: colorScheme.onSurface),
        titleSmall: AppTypography.titleSmall.copyWith(color: colorScheme.onSurface),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: colorScheme.onSurface.withOpacity(0.7)),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: colorScheme.onSurface.withOpacity(0.7)),
        bodySmall: AppTypography.bodySmall.copyWith(color: colorScheme.onSurface.withOpacity(0.7)),
        labelLarge: AppTypography.labelLarge.copyWith(color: colorScheme.onSurface),
        labelMedium: AppTypography.labelMedium.copyWith(color: colorScheme.onSurface),
        labelSmall: AppTypography.labelSmall.copyWith(color: colorScheme.onSurface),
      ),

      // Theme Extensions
      extensions: [extension],

      // Button Theme mapping
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
        ),
      ),

      // Input Decoration mapping
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.3), width: 1.5),
        ),
      ),

      // Audio Slider Theme mapping
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.onSurface.withOpacity(0.12),
        thumbColor: colorScheme.primary,
        trackHeight: 4.0,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
        valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
      ),

      // Switch Theme mapping
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return colorScheme.onSurface.withOpacity(0.38);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary.withOpacity(0.24);
          return colorScheme.onSurface.withOpacity(0.12);
        }),
      ),

      // Navigation Bar mapping
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        indicatorColor: colorScheme.primary.withOpacity(0.12),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 80,
      ),

      // Bottom Sheet Theme mapping
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: AppRadius.bottomSheetRadius,
        elevation: 0,
      ),

      // Dialog Theme mapping
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.dialogRadius),
        elevation: 0,
      ),
    );
  }

  // Pre-configured standard themes
  static ThemeData get dark => buildTheme(darkColorScheme, darkThemeExtension);
  static ThemeData get amoled => buildTheme(amoledColorScheme, amoledThemeExtension);
  static ThemeData get highContrast => buildTheme(highContrastColorScheme, highContrastThemeExtension);
}
