import 'package:flutter/material.dart';
import '../../../domain/entities/song.dart';
import '../../design_tokens/spacing.dart';
import '../../extensions/context_extensions.dart';
import '../sheets/raaga_bottom_sheet.dart';

class RaagaContextMenuOption {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const RaagaContextMenuOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class RaagaContextMenu extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<RaagaContextMenuOption> options;

  const RaagaContextMenu({
    super.key,
    required this.title,
    this.subtitle,
    required this.options,
  });

  static void show({
    required BuildContext context,
    required String title,
    String? subtitle,
    required List<RaagaContextMenuOption> options,
  }) {
    RaagaBottomSheet.show(
      context: context,
      title: title,
      child: RaagaContextMenu(
        title: title,
        subtitle: subtitle,
        options: options,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.50),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return ListTile(
              leading: Icon(
                option.icon,
                color: context.colorScheme.onSurface.withOpacity(0.70),
              ),
              title: Text(
                option.label,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                option.onTap();
              },
            );
          },
        ),
      ],
    );
  }
}
