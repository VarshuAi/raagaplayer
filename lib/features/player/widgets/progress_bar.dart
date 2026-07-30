import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../provider/playback_provider.dart';
import '../../../core/services/haptic_service.dart';

class PlayerProgressBar extends ConsumerWidget {
  const PlayerProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(playbackPositionProvider).value ?? Duration.zero;
    final duration = ref.watch(playbackDurationProvider).value ?? Duration.zero;
    final engine = ref.watch(audioEngineProvider);

    final positionMs = position.inMilliseconds.toDouble();
    final durationMs = duration.inMilliseconds.toDouble();

    return Column(
      children: [
        Slider(
          value: positionMs.clamp(0.0, durationMs > 0 ? durationMs : 1.0),
          min: 0.0,
          max: durationMs > 0 ? durationMs : 1.0,
          onChanged: (value) {
            HapticService.selection();
            engine.seek(Duration(milliseconds: value.toInt()));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.50),
                ),
              ),
              Text(
                _formatDuration(duration - position),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.50),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    if (d.isNegative) return "0:00";
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return "$minutes:${seconds < 10 ? '0' : ''}$seconds";
  }
}
