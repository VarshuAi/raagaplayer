import 'package:flutter/material.dart';
import 'colors.dart';

class AppSurfaces {
  AppSurfaces._();

  // Dark Mode Surface System
  static const Color surface0 = AppColors.background;
  static const Color surface1 = AppColors.surfaceSecondary;
  static const Color surface2 = AppColors.surfaceElevated;
  static const Color surface3 = AppColors.surfaceCard;
  static const Color surface4 = Color(0xFF282B33);

  // AMOLED Mode Surface System
  static const Color amoledSurface0 = AppColors.amoledBackground;
  static const Color amoledSurface1 = AppColors.amoledSurfaceSecondary;
  static const Color amoledSurface2 = AppColors.amoledSurfaceElevated;
  static const Color amoledSurface3 = AppColors.amoledSurfaceCard;
  static const Color amoledSurface4 = Color(0xFF1B1B1E);
}
