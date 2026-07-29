import 'package:flutter/animation.dart';

class AppCurves {
  AppCurves._();

  // Natural easing curves matching Android M3 / Material guidelines
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOut;
  static const Curve linear = Curves.linear;

  // Premium Custom Curves
  static const Curve fluid = Cubic(0.2, 0.8, 0.2, 1.0);
  static const Curve overshoot = Cubic(0.34, 1.56, 0.64, 1.0);
  static const Curve decelerate = Cubic(0.0, 0.0, 0.2, 1.0);
}
