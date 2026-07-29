import 'package:flutter/material.dart';
import 'curves.dart';
import 'durations.dart';

class AppTransitions {
  AppTransitions._();

  // Premium Fade transition builder
  static PageRouteBuilder<T> fadeRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.standard,
      reverseTransitionDuration: AppDurations.fast,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: AppCurves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }

  // Premium Scale route builder (e.g. for opening artwork details or full player overlay)
  static PageRouteBuilder<T> scaleRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.slow,
      reverseTransitionDuration: AppDurations.standard,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: AppCurves.fluid),
        );
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: AppCurves.easeInOut),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );
  }

  // Premium shared axis slide transition
  static PageRouteBuilder<T> slideRoute<T>(Widget page, {Offset beginOffset = const Offset(0.0, 0.08)}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.slow,
      reverseTransitionDuration: AppDurations.standard,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
          CurvedAnimation(parent: animation, curve: AppCurves.fluid),
        );
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: AppCurves.easeInOut),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
