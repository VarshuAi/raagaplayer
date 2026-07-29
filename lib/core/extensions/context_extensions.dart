import 'package:flutter/material.dart';
import '../theme/theme_extension.dart';
import '../utils/responsive.dart';

extension BuildContextExtensions on BuildContext {
  // Shortcut to access Theme
  ThemeData get theme => Theme.of(this);

  // Shortcut to access ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  // Shortcut to access TextTheme
  TextTheme get textTheme => theme.textTheme;

  // Shortcut to access media query screen size
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // Shortcut to access custom RaagaThemeExtension
  RaagaThemeExtension get raagaTheme => theme.extension<RaagaThemeExtension>()!;

  // Shortcut to determine device responsive type
  RaagaDeviceType get responsiveType => RaagaResponsive.getDeviceType(this);
  bool get isCompact => RaagaResponsive.isCompact(this);
  bool get isMedium => RaagaResponsive.isMedium(this);
  bool get isExpanded => RaagaResponsive.isExpanded(this);

  // Shortcut to access device padding (safe area)
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;
}
