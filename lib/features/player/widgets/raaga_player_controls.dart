import 'package:flutter/material.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../../../core/icons/raaga_icons.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/layout/animation_presets.dart';

class RaagaPlayerControls extends StatelessWidget {
  final bool isPlaying;
  final bool isShuffleEnabled;
  final bool isRepeatEnabled;
  final VoidCallback onPlayPause;
  final VoidCallback onSkipNext;
  final VoidCallback onSkipPrevious;
  final VoidCallback onToggleShuffle;
  final VoidCallback onToggleRepeat;

  const RaagaPlayerControls({
    super.key,
    required this.isPlaying,
    required this.isShuffleEnabled,
    required this.isRepeatEnabled,
    required this.onPlayPause,
    required this.onSkipNext,
    required this.onSkipPrevious,
    required this.onToggleShuffle,
    required this.onToggleRepeat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Shuffle toggle
        RaagaIconButton(
          icon: RaagaIcons.shuffle,
          color: isShuffleEnabled
              ? context.colorScheme.primary
              : context.colorScheme.onSurface.withOpacity(0.38),
          onTap: onToggleShuffle,
        ),
        // Previous track
        RaagaIconButton(
          icon: RaagaIcons.previous,
          size: 32,
          onTap: onSkipPrevious,
        ),
        // Play / Pause Circle
        AnimatedTap(
          onTap: onPlayPause,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.primary,
            ),
            alignment: Alignment.center,
            child: Icon(
              isPlaying ? RaagaIcons.pause : RaagaIcons.play,
              size: 36,
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
        // Next track
        RaagaIconButton(
          icon: RaagaIcons.next,
          size: 32,
          onTap: onSkipNext,
        ),
        // Repeat toggle
        RaagaIconButton(
          icon: RaagaIcons.repeat,
          color: isRepeatEnabled
              ? context.colorScheme.primary
              : context.colorScheme.onSurface.withOpacity(0.38),
          onTap: onToggleRepeat,
        ),
      ],
    );
  }
}
