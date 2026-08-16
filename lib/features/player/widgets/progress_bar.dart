import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../provider/playback_provider.dart';
import '../../../music/presentation/providers/music_providers.dart';
import '../../../core/services/haptic_service.dart';

class PlayerProgressBar extends ConsumerWidget {
  final Color? ambientColor;

  const PlayerProgressBar({
    super.key,
    this.ambientColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(playbackSessionProvider);
    final position = session.position;
    final duration = session.duration;
    final engine = ref.watch(audioEngineProvider);
    final activeColor = ambientColor ?? context.colorScheme.primary;

    final positionMs = position.inMilliseconds.toDouble();
    final durationMs = duration.inMilliseconds.toDouble();

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: activeColor,
            thumbColor: activeColor,
            inactiveTrackColor: Colors.white.withOpacity(0.2),
            overlayColor: activeColor.withOpacity(0.2),
            trackHeight: 3.5,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
          ),
          child: Slider(
            value: positionMs.clamp(0.0, durationMs > 0 ? durationMs : 1.0),
            min: 0.0,
            max: durationMs > 0 ? durationMs : 1.0,
            onChanged: (value) {
              HapticService.selection();
              engine.seek(Duration(milliseconds: value.toInt()));
            },
          ),
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
