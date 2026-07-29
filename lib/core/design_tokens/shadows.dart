import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static final List<BoxShadow> level1 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 8.0,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> level2 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.16),
      blurRadius: 16.0,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> level3 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.24),
      blurRadius: 24.0,
      offset: const Offset(0, 8),
    ),
  ];

  // Glow shadow for album artwork visual focus
  static final List<BoxShadow> albumArtGlow = [
    BoxShadow(
      color: const Color(0xFF8B5CF6).withOpacity(0.15),
      blurRadius: 32.0,
      offset: const Offset(0, 16),
      spreadRadius: -4.0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 24.0,
      offset: const Offset(0, 12),
    ),
  ];
}
