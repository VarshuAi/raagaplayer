import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../design_tokens/spacing.dart';
import '../../extensions/context_extensions.dart';
import '../layout/glass_container.dart';

class RaagaBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? trailing;

  const RaagaBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.trailing,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Widget? trailing,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RaagaBottomSheet(
        title: title,
        child: child,
        trailing: trailing,
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
              // Drag Handle
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
                  child: Row(
                    children: [
                      const SizedBox(width: 32), // spacer to match trailing
                      Expanded(
                        child: Text(
                          title!,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (trailing != null)
                        trailing!
                      else
                        const SizedBox(width: 32),
                    ],
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
