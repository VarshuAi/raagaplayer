import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Dark Mode Base Color Tokens (Deep Pitch Black with subtle purple tint)
  static const Color background = Color(0xFF07070B);
  static const Color surfaceSecondary = Color(0xFF0F0F17);
  static const Color surfaceElevated = Color(0xFF151522);
  static const Color surfaceCard = Color(0xFF1C1C2B);
  static const Color divider = Color(0x1AFFFFFF); // rgba(255,255,255,0.10)

  // AMOLED Base Color Tokens
  static const Color amoledBackground = Color(0xFF000000);
  static const Color amoledSurfaceSecondary = Color(0xFF08080B);
  static const Color amoledSurfaceElevated = Color(0xFF0F0F14);
  static const Color amoledSurfaceCard = Color(0xFF14141E);

  // Neon Gradient & Brand Accents
  static const Color primaryAccent = Color(0xFF903AFF);   // Vibrant Electric Purple
  static const Color secondaryAccent = Color(0xFFFF3579); // Vibrant Electric Pink
  static const Color gradientStart = Color(0xFFFF3579);
  static const Color gradientEnd = Color(0xFF903AFF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Status & Feedback Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Typography Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0x99FFFFFF); // rgba(255,255,255,0.60)
  static const Color disabled = Color(0x3DFFFFFF);      // rgba(255,255,255,0.24)
}
