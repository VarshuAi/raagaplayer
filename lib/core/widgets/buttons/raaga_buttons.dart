import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../design_tokens/spacing.dart';
import '../../extensions/context_extensions.dart';
import '../layout/animation_presets.dart';

class RaagaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSecondary;
  final IconData? icon;
  final bool isLoading;

  const RaagaButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isSecondary = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSecondary
        ? context.colorScheme.surfaceContainer
        : context.colorScheme.primary;
    final Color textColor = isSecondary
        ? context.colorScheme.onSurface
        : context.colorScheme.onPrimary;

    return AnimatedTap(
      onTap: isLoading ? null : onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 48.0, // Minimum accessible touch target
          minWidth: 88.0,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              else ...[
                if (icon != null) ...[
                  Icon(icon, size: 18, color: textColor),
                  const SizedBox(width: AppSpacing.xs),
                ],
                Text(
                  text,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class RaagaIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color? color;
  final String? tooltip;

  const RaagaIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 24.0,
    this.color,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTap(
      onTap: onTap,
      child: Tooltip(
        message: tooltip ?? '',
        child: Container(
          width: 48.0, // Minimum accessible touch target
          height: 48.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: size,
            color: color ?? context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class RaagaTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const RaagaTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTap(
      onTap: onTap,
      child: Container(
        height: 48.0, // Minimum accessible touch target
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        alignment: Alignment.center,
        child: Text(
          text,
          style: context.textTheme.labelLarge?.copyWith(
            color: color ?? context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
