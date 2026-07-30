import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/player_provider.dart';
import '../provider/artwork_provider.dart';
import '../widgets/artwork_background.dart';
import '../widgets/artwork_view.dart';
import '../widgets/playback_controls.dart';
import '../widgets/progress_bar.dart';
import '../widgets/player_top_bar.dart';
import '../widgets/player_bottom_actions.dart';
import '../widgets/lyrics_panel.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';

enum PlayerMode { compact, standard, lyricsFocus }

class NowPlayingScreen extends ConsumerStatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  ConsumerState<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends ConsumerState<NowPlayingScreen> {
  PlayerMode _currentMode = PlayerMode.standard;

  @override
  Widget build(BuildContext context) {
    final song = ref.watch(currentSongProvider);
    final palette = ref.watch(artworkPaletteProvider);

    if (song == null) {
      return const Scaffold(
        body: Center(
          child: Text('No song selected'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black, // Dark/AMOLED background base
      body: Stack(
        children: [
          // Blurred background visualizer
          const Positioned.fill(
            child: ArtworkBackground(),
          ),

          // Main Screen layout
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const PlayerTopBar(),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 0.96, end: 1.0).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _buildPlayerContent(song),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_currentMode != PlayerMode.lyricsFocus) ...[
                          const PlayerProgressBar(),
                          const SizedBox(height: AppSpacing.md),
                          const PlaybackControls(),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        PlayerBottomActions(
                          lyricsActive: _currentMode == PlayerMode.lyricsFocus,
                          onLyricsTap: () {
                            setState(() {
                              _currentMode = _currentMode == PlayerMode.lyricsFocus
                                  ? PlayerMode.standard
                                  : PlayerMode.lyricsFocus;
                            });
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerContent(dynamic song) {
    switch (_currentMode) {
      case PlayerMode.lyricsFocus:
        return const KeyedSubtree(
          key: ValueKey('lyrics_focus'),
          child: LyricsPanel(),
        );

      case PlayerMode.compact:
        return KeyedSubtree(
          key: const ValueKey('compact_mode'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlayerArtworkView(
                imageUrl: song.artworkUrl,
                heroTag: 'artwork_comp_hero',
                onSwipeLeft: () {},
                onSwipeRight: () {},
              ),
              const SizedBox(height: AppSpacing.xl),
              _buildSongInfo(song),
            ],
          ),
        );

      case PlayerMode.standard:
      default:
        return KeyedSubtree(
          key: const ValueKey('standard_mode'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlayerArtworkView(
                imageUrl: song.artworkUrl,
                heroTag: 'artwork_std_hero',
                onSwipeLeft: () {},
                onSwipeRight: () {},
              ),
              _buildSongInfo(song),
            ],
          ),
        );
    }
  }

  Widget _buildSongInfo(dynamic song) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            song.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            song.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.70),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
