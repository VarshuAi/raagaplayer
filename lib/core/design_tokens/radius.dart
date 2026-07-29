import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const double chip = 16.0;
  static const double button = 18.0;
  static const double card = 22.0;
  static const double dialog = 24.0;
  static const double navigation = 24.0;
  static const double albumArt = 28.0;
  static const double bottomSheet = 32.0;

  // BorderRadius helpers
  static final BorderRadius chipRadius = BorderRadius.circular(chip);
  static final BorderRadius buttonRadius = BorderRadius.circular(button);
  static final BorderRadius cardRadius = BorderRadius.circular(card);
  static final BorderRadius dialogRadius = BorderRadius.circular(dialog);
  static final BorderRadius navigationRadius = BorderRadius.circular(navigation);
  static final BorderRadius albumArtRadius = BorderRadius.circular(albumArt);
  static final BorderRadius bottomSheetRadius = const BorderRadius.vertical(top: Radius.circular(bottomSheet));
}
