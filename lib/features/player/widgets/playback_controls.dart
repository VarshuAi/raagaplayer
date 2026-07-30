import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../../../core/widgets/layout/animation_presets.dart';
import '../../../core/icons/raaga_icons.dart';
import '../../../core/extensions/context_extensions.dart';
import '../provider/playback_provider.dart';
import '../provider/queue_provider.dart';
import '../../../core/audio/audio_state.dart';
import '../../../core/services/haptic_service.dart';

class PlaybackControls extends ConsumerWidget {
  const PlaybackControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlayingVal = ref.watch(playbackStateProvider).value == RaagaPlaybackState.playing;
    final engine = ref.watch(audioEngineProvider);
    final queue = ref.watch(queueProvider);
    final indexNotifier = ref.watch(queueProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Shuffle toggle button
        IconButton(
          icon: const Icon(RaagaIcons.shuffle),
          onPressed: () {
            HapticService.light();
            indexNotifier.shuffle();
          },
        ),
        // Previous song button
        RaagaIconButton(
          icon: RaagaIcons.previous,
          size: 32,
          onTap: () {
            HapticService.medium();
            indexNotifier.remove(0); // placeholder skip previous trigger
          },
        ),
        // Play / Pause button
        AnimatedTap(
          onTap: () {
            HapticService.medium();
            if (isPlayingVal) {
              engine.pause();
            } else {
              engine.play();
            }
          },
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.primary,
            ),
            child: Icon(
              isPlayingVal ? RaagaIcons.pause : RaagaIcons.play,
              size: 36,
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
        // Next song button
        RaagaIconButton(
          icon: RaagaIcons.next,
          size: 32,
          onTap: () {
            HapticService.medium();
            indexNotifier.remove(0); // placeholder skip next trigger
          },
        ),
        // Repeat toggle button
        IconButton(
          icon: const Icon(RaagaIcons.repeat),
          onPressed: () {
            HapticService.light();
          },
        ),
      ],
    );
  }
}
