import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../settings/provider/settings_provider.dart';

class AudioQualitySheet extends ConsumerWidget {
  const AudioQualitySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final currentQuality = settings.audioQuality;

    final options = [
      {
        'id': '320kbps',
        'label': 'High (320 kbps)',
        'subtitle': 'Lossless / HD Crystal Clear Audio',
        'icon': Icons.graphic_eq_rounded,
        'tag': '320k HD',
      },
      {
        'id': '160kbps',
        'label': 'Medium (160 kbps)',
        'subtitle': 'Standard Balanced Streaming',
        'icon': Icons.tune_rounded,
        'tag': '160k',
      },
      {
        'id': '96kbps',
        'label': 'Low (96 kbps)',
        'subtitle': 'Data Saver (Saves Mobile Data)',
        'icon': Icons.network_check_rounded,
        'tag': '96k',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Icon(
                  Icons.high_quality_rounded,
                  color: context.colorScheme.primary,
                  size: 26,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Streaming & Audio Quality',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              'Applies to online playback streaming & offline downloads.',
              style: TextStyle(
                color: context.colorScheme.onSurface.withOpacity(0.50),
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(),
          ...options.map((opt) {
            final isSelected = currentQuality == opt['id'];

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 4),
              leading: Icon(
                opt['icon'] as IconData,
                color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface.withOpacity(0.60),
                size: 24,
              ),
              title: Row(
                children: [
                  Text(
                    opt['label'] as String,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected ? context.colorScheme.primary.withOpacity(0.2) : context.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      opt['tag'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                opt['subtitle'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onSurface.withOpacity(0.50),
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle_rounded,
                      color: context.colorScheme.primary,
                    )
                  : null,
              onTap: () {
                notifier.updateSettings(
                  settings.copyWith(audioQuality: opt['id'] as String),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Audio quality set to ${opt['label']}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            );
          }).toList(),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
