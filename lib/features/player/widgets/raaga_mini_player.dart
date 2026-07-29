import 'package:flutter/material.dart';
import '../../../core/widgets/layout/glass_container.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/icons/raaga_icons.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/song.dart';

class RaagaMiniPlayer extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final double progress; // value between 0.0 and 1.0
  final VoidCallback onTap;
  final VoidCallback onPlayPause;
  final VoidCallback onSkipNext;

  const RaagaMiniPlayer({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.progress,
    required this.onTap,
    required this.onPlayPause,
    required this.onSkipNext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.md),
        child: RaagaGlassContainer(
          borderRadius: BorderRadius.circular(16.0),
          opacity: 0.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Horizontal details row
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Row(
                  children: [
                    RaagaArtwork(
                      imageUrl: song.artworkUrl,
                      size: 48.0,
                      radius: 12.0,
                      heroTag: 'mini_player_art',
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            song.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurface.withOpacity(0.50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action controls
                    RaagaIconButton(
                      icon: isPlaying ? RaagaIcons.pause : RaagaIcons.play,
                      size: 24,
                      onTap: onPlayPause,
                    ),
                    RaagaIconButton(
                      icon: RaagaIcons.next,
                      size: 24,
                      onTap: onSkipNext,
                    ),
                  ],
                ),
              ),
              // Compact horizontal track progress bar
              RaagaProgressIndicator(value: progress),
            ],
          ),
        ),
      ),
    );
  }
}
