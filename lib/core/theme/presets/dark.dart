import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/surfaces.dart';
import '../../design_tokens/shadows.dart';
import '../theme_extension.dart';
import '../app_typography.dart';

final RaagaThemeExtension darkThemeExtension = RaagaThemeExtension(
  surfaceHigh: AppSurfaces.surface4,
  surfaceLow: AppSurfaces.surface1,
  lyricsOverlay: Colors.black.withOpacity(0.6),
  albumShadow: AppShadows.albumArtGlow,
  playerGradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF15161A),
      Color(0xFF0B0B0D),
    ],
  ),
);

final ColorScheme darkColorScheme = const ColorScheme.dark(
  primary: AppColors.primaryAccent,
  secondary: AppColors.secondaryAccent,
  surface: AppColors.background,
  onSurface: AppColors.textPrimary,
  surfaceContainerLow: AppColors.surfaceSecondary,
  surfaceContainer: AppColors.surfaceElevated,
  surfaceContainerHigh: AppColors.surfaceCard,
  error: AppColors.error,
  onError: AppColors.textPrimary,
);
