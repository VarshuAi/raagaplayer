import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ArtworkPalette {
  final Color dominantColor;
  final Color vibrantColor;
  final Color darkColor;

  const ArtworkPalette({
    required this.dominantColor,
    required this.vibrantColor,
    required this.darkColor,
  });

  factory ArtworkPalette.fallback() {
    return const ArtworkPalette(
      dominantColor: Color(0xFF15161A),
      vibrantColor: Color(0xFF8B5CF6),
      darkColor: Color(0xFF0B0B0D),
    );
  }
}

class PaletteService {
  PaletteService._();

  static Future<ArtworkPalette> extractPalette(ImageProvider imageProvider) async {
    try {
      final generator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        maximumColorCount: 8,
      );
      
      final dominant = generator.dominantColor?.color ?? const Color(0xFF15161A);
      final vibrant = generator.vibrantColor?.color ?? const Color(0xFF8B5CF6);
      final dark = generator.darkMutedColor?.color ?? const Color(0xFF0B0B0D);

      return ArtworkPalette(
        dominantColor: dominant,
        vibrantColor: vibrant,
        darkColor: dark,
      );
    } catch (e) {
      return ArtworkPalette.fallback();
    }
  }
}
