import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/surfaces.dart';
import '../../design_tokens/shadows.dart';
import '../theme_extension.dart';

final RaagaThemeExtension amoledThemeExtension = RaagaThemeExtension(
  surfaceHigh: AppSurfaces.amoledSurface4,
  surfaceLow: AppSurfaces.amoledSurface1,
  lyricsOverlay: Colors.black.withOpacity(0.85),
  albumShadow: AppShadows.albumArtGlow,
  playerGradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000000),
      Color(0xFF000000),
    ],
  ),
);

final ColorScheme amoledColorScheme = const ColorScheme.dark(
  primary: AppColors.primaryAccent,
  secondary: AppColors.secondaryAccent,
  surface: AppColors.amoledBackground,
  onSurface: AppColors.textPrimary,
  surfaceContainerLow: AppColors.amoledSurfaceSecondary,
  surfaceContainer: AppColors.amoledSurfaceElevated,
  surfaceContainerHigh: AppColors.amoledSurfaceCard,
  error: AppColors.error,
  onError: AppColors.textPrimary,
);
