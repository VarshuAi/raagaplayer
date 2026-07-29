import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../features/dashboard/screens/design_system_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.designSystem:
      case AppRoutes.home:
      default:
        return MaterialPageRoute(
          builder: (context) => const DesignSystemScreen(),
          settings: settings,
        );
    }
  }
}
