import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Dark Mode Base Color Tokens
  static const Color background = Color(0xFF0B0B0D);
  static const Color surfaceSecondary = Color(0xFF15161A);
  static const Color surfaceElevated = Color(0xFF1D1F24);
  static const Color surfaceCard = Color(0xFF202228);
  static const Color divider = Color(0x0FFFFFFF); // rgba(255,255,255,0.06)

  // AMOLED Base Color Tokens
  static const Color amoledBackground = Color(0xFF000000);
  static const Color amoledSurfaceSecondary = Color(0xFF0A0A0C);
  static const Color amoledSurfaceElevated = Color(0xFF111114);
  static const Color amoledSurfaceCard = Color(0xFF161619);

  // Accents & Brand Colors
  static const Color primaryAccent = Color(0xFF8B5CF6);   // #8B5CF6 (Vibrant Purple)
  static const Color secondaryAccent = Color(0xFFA855F7); // #A855F7 (Vibrant Violet)

  // Status & Feedback Colors
  static const Color success = Color(0xFF22C55E); // #22C55E
  static const Color warning = Color(0xFFF59E0B); // #F59E0B
  static const Color error = Color(0xFFEF4444);   // #EF4444

  // Typography Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB2FFFFFF); // rgba(255,255,255,0.70)
  static const Color disabled = Color(0x61FFFFFF);      // rgba(255,255,255,0.38)
}
