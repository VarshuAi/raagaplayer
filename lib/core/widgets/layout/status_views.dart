import 'package:flutter/material.dart';
import '../../extensions/context_extensions.dart';
import '../buttons/raaga_buttons.dart';

class RaagaEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onActionTap;

  const RaagaEmptyState({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: context.colorScheme.onSurface.withOpacity(0.24),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onActionTap != null) ...[
              const SizedBox(height: 24),
              RaagaButton(
                text: actionText!,
                onTap: onActionTap,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class RaagaErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const RaagaErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: context.colorScheme.error.withOpacity(0.6),
            ),
            const SizedBox(height: 24),
            Text(
              "Playback Error",
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            RaagaButton(
              text: "Retry Connection",
              onTap: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
