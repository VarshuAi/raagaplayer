import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';
import '../../design_tokens/surfaces.dart';

final RaagaThemeExtension highContrastThemeExtension = RaagaThemeExtension(
  surfaceHigh: const Color(0xFF33363F),
  surfaceLow: const Color(0xFF1C1D22),
  lyricsOverlay: Colors.black.withOpacity(0.9),
  albumShadow: const [],
  playerGradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1C1D22),
      Color(0xFF000000),
    ],
  ),
);

final ColorScheme highContrastColorScheme = const ColorScheme.dark(
  primary: Colors.white,
  secondary: AppColors.secondaryAccent,
  surface: Color(0xFF000000),
  onSurface: Colors.white,
  surfaceContainerLow: Color(0xFF1A1A1A),
  surfaceContainer: Color(0xFF262626),
  surfaceContainerHigh: Color(0xFF333333),
  error: AppColors.error,
  onError: Colors.black,
);
