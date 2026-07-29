import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/shadows.dart';
import '../../extensions/context_extensions.dart';
import '../layout/animation_presets.dart';

class RaagaCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final int surfaceLevel; // 1 to 4 surface depth
  final bool showShadow;

  const RaagaCard({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.surfaceLevel = 2,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    Color surfaceColor;
    switch (surfaceLevel) {
      case 1:
        surfaceColor = context.colorScheme.surfaceContainerLow;
        break;
      case 3:
        surfaceColor = context.colorScheme.surfaceContainerHigh;
        break;
      case 4:
        surfaceColor = context.raagaTheme.surfaceHigh ?? context.colorScheme.surfaceContainerHigh;
        break;
      case 2:
      default:
        surfaceColor = context.colorScheme.surfaceContainer;
        break;
    }

    final cardWidget = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: context.colorScheme.onSurface.withOpacity(0.04),
          width: 1.0,
        ),
        boxShadow: showShadow ? AppShadows.level1 : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return AnimatedTap(
        onTap: onTap,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
