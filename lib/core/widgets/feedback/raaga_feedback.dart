import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../design_tokens/spacing.dart';
import '../../extensions/context_extensions.dart';
import '../layout/glass_container.dart';

class RaagaBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool isDismissible;

  const RaagaBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.isDismissible = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Required for custom rounded background / blurs
      builder: (context) => RaagaBottomSheet(
        title: title,
        isDismissible: isDismissible,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaagaGlassContainer(
      borderRadius: AppRadius.bottomSheetRadius,
      opacity: 0.12,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.sm),
              // Drag Indicator
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Text(
                    title!,
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class RaagaDialog extends StatelessWidget {
  final String title;
  final String content;
  final Widget? actions;

  const RaagaDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String content,
    Widget? actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => RaagaDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: RaagaGlassContainer(
          width: context.screenWidth * 0.85,
          borderRadius: BorderRadius.circular(AppRadius.dialog),
          padding: const EdgeInsets.all(AppSpacing.xl),
          opacity: 0.14,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                content,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.70),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              if (actions != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: actions!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class RaagaSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: RaagaGlassContainer(
        borderRadius: BorderRadius.circular(AppRadius.button),
        opacity: 0.15,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
        border: Border.all(
          color: isError ? context.colorScheme.error : context.colorScheme.primary.withOpacity(0.3),
          width: 1.0,
        ),
        child: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
              color: isError ? context.colorScheme.error : context.colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                message,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
