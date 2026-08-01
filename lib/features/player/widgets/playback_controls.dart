import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../../../core/widgets/layout/animation_presets.dart';
import '../../../core/icons/raaga_icons.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/playback/playback_session.dart';
import '../provider/playback_provider.dart';
import '../../../core/audio/audio_state.dart';
import '../../../core/services/haptic_service.dart';
import '../../../music/presentation/providers/music_providers.dart';

class PlaybackControls extends ConsumerWidget {
  final Color? ambientColor;

  const PlaybackControls({
    super.key,
    this.ambientColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(playbackSessionProvider);
    final isPlayingVal = session.state == RaagaPlaybackState.playing;
    final isShuffle = session.shuffle;
    final repeatMode = session.repeatMode;
    final engine = ref.watch(audioEngineProvider);
    final activeColor = ambientColor ?? context.colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Shuffle toggle button
        IconButton(
          icon: Icon(
            RaagaIcons.shuffle,
            color: isShuffle ? activeColor : null,
          ),
          tooltip: 'Toggle Shuffle',
          onPressed: () {
            HapticService.light();
            ref.read(playbackSessionProvider.notifier).toggleShuffle();
          },
        ),
        // Previous song button
        RaagaIconButton(
          icon: RaagaIcons.previous,
          size: 32,
          onTap: () {
            HapticService.medium();
            ref.read(playbackSessionProvider.notifier).playPrevious();
          },
        ),
        // Play / Pause button dynamically styled with ambient color
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
              color: activeColor,
              boxShadow: [
                BoxShadow(
                  color: activeColor.withOpacity(0.4),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              isPlayingVal ? RaagaIcons.pause : RaagaIcons.play,
              size: 36,
              color: Colors.white,
            ),
          ),
        ),
        // Next song button
        RaagaIconButton(
          icon: RaagaIcons.next,
          size: 32,
          onTap: () {
            HapticService.medium();
            ref.read(playbackSessionProvider.notifier).playNext();
          },
        ),
        // Repeat mode toggle button
        IconButton(
          icon: Icon(
            repeatMode == AudioRepeatMode.one
                ? Icons.repeat_one_rounded
                : (repeatMode == AudioRepeatMode.all ? Icons.repeat_on_rounded : Icons.repeat_rounded),
            color: repeatMode != AudioRepeatMode.off ? activeColor : null,
          ),
          tooltip: 'Toggle Repeat Mode',
          onPressed: () {
            HapticService.light();
            ref.read(playbackSessionProvider.notifier).toggleRepeatMode();
          },
        ),
      ],
    );
  }
}
