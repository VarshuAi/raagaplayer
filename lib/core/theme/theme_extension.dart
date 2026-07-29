import 'package:flutter/material.dart';

class RaagaThemeExtension extends ThemeExtension<RaagaThemeExtension> {
  final Color? surfaceHigh;
  final Color? surfaceLow;
  final Color? lyricsOverlay;
  final List<BoxShadow>? albumShadow;
  final LinearGradient? playerGradient;

  const RaagaThemeExtension({
    required this.surfaceHigh,
    required this.surfaceLow,
    required this.lyricsOverlay,
    required this.albumShadow,
    required this.playerGradient,
  });

  @override
  RaagaThemeExtension copyWith({
    Color? surfaceHigh,
    Color? surfaceLow,
    Color? lyricsOverlay,
    List<BoxShadow>? albumShadow,
    LinearGradient? playerGradient,
  }) {
    return RaagaThemeExtension(
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      surfaceLow: surfaceLow ?? this.surfaceLow,
      lyricsOverlay: lyricsOverlay ?? this.lyricsOverlay,
      albumShadow: albumShadow ?? this.albumShadow,
      playerGradient: playerGradient ?? this.playerGradient,
    );
  }

  @override
  RaagaThemeExtension lerp(
    ThemeExtension<RaagaThemeExtension>? other,
    double t,
  ) {
    if (other is! RaagaThemeExtension) {
      return this;
    }
    return RaagaThemeExtension(
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t),
      surfaceLow: Color.lerp(surfaceLow, other.surfaceLow, t),
      lyricsOverlay: Color.lerp(lyricsOverlay, other.lyricsOverlay, t),
      albumShadow: other.albumShadow, // Lerping lists of shadows is omitted for simplicity
      playerGradient: LinearGradient.lerp(playerGradient, other.playerGradient, t),
    );
  }
}
