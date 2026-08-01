import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/layout/glass_container.dart';
import '../../../core/widgets/layout/raaga_artwork_palette.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/icons/raaga_icons.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/song.dart';
import '../provider/playback_provider.dart';
import '../provider/artwork_provider.dart';
import '../../../core/audio/audio_state.dart';
import '../../../music/presentation/providers/music_providers.dart';

class RaagaMiniPlayer extends ConsumerWidget {
  final Song song;
  final VoidCallback onTap;

  const RaagaMiniPlayer({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read active playback states
    final isPlayingVal = ref.watch(playbackStateProvider).value == RaagaPlaybackState.playing;
    final position = ref.watch(playbackPositionProvider).value ?? Duration.zero;
    final duration = ref.watch(playbackDurationProvider).value ?? Duration.zero;
    final palette = ref.watch(artworkPaletteProvider);
    final engine = ref.watch(audioEngineProvider);

    final double progress = duration.inMilliseconds > 0
        ? (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4.0),
        child: RaagaGlassContainer(
          borderRadius: BorderRadius.circular(16.0),
          opacity: 0.12,
          border: Border.all(
            color: palette.vibrantColor.withOpacity(0.15),
            width: 1.5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Row(
                  children: [
                    // Visual focus album art with color palette extraction callback
                    RaagaArtworkPalette(
                      imageUrl: song.artworkUrl,
                      size: 48.0,
                      radius: 12.0,
                      heroTag: 'mini_player_art_hero',
                      onPaletteExtracted: (newPalette) {
                        ref.read(artworkPaletteProvider.notifier).state = newPalette;
                      },
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RaagaIconButton(
                          icon: Icons.skip_previous_rounded,
                          size: 22,
                          onTap: () {
                            ref.read(playbackSessionProvider.notifier).playPrevious();
                          },
                        ),
                        const SizedBox(width: 4),
                        RaagaIconButton(
                          icon: isPlayingVal ? RaagaIcons.pause : RaagaIcons.play,
                          size: 26,
                          onTap: () {
                            if (isPlayingVal) {
                              engine.pause();
                            } else {
                              engine.play();
                            }
                          },
                        ),
                        const SizedBox(width: 4),
                        RaagaIconButton(
                          icon: Icons.skip_next_rounded,
                          size: 22,
                          onTap: () {
                            ref.read(playbackSessionProvider.notifier).playNext();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              RaagaProgressIndicator(value: progress),
            ],
          ),
        ),
      ),
    );
  }
}
