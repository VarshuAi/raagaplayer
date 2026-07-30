import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/sheets/raaga_bottom_sheet.dart';
import '../../../core/extensions/context_extensions.dart';
import '../provider/playback_speed_provider.dart';

class PlaybackSpeedSheet extends ConsumerWidget {
  const PlaybackSpeedSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSpeed = ref.watch(playbackSpeedProvider);
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

    return RaagaBottomSheet(
      title: 'Playback Speed',
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: speeds.length,
        itemBuilder: (context, index) {
          final speed = speeds[index];
          final isSelected = speed == currentSpeed;
          return ListTile(
            title: Text(
              '${speed}x',
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected ? Icon(Icons.check_rounded, color: context.colorScheme.primary) : null,
            onTap: () {
              ref.read(playbackSpeedProvider.notifier).setSpeed(speed);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
