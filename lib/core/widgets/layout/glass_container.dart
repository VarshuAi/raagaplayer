import 'dart:ui';
import 'package:flutter/material.dart';
import '../../design_tokens/blur.dart';
import '../../design_tokens/radius.dart';
import '../../extensions/context_extensions.dart';

class RaagaGlassContainer extends StatelessWidget {
  final Widget child;
  final double blurAmount;
  final double opacity;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsetsGeometry padding;

  const RaagaGlassContainer({
    super.key,
    required this.child,
    this.blurAmount = AppBlur.medium,
    this.opacity = 0.08,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(AppRadius.card);
    return ClipRRect(
      borderRadius: effectiveRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: context.colorScheme.onSurface.withOpacity(opacity),
            borderRadius: effectiveRadius,
            border: border ??
                Border.all(
                  color: context.colorScheme.onSurface.withOpacity(0.06),
                  width: 1.0,
                ),
          ),
          child: child,
        ),
      ),
    );
  }
}
