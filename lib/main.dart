import 'package:flutter/material';
import 'core/theme/app_theme.dart';
import 'features/dashboard/screens/design_system_screen.dart';

void main() {
  runApp(const RaagaApp());
}

class RaagaApp extends StatelessWidget {
  const RaagaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raaga',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const DesignSystemScreen(),
    );
  }
}
