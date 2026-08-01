import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
import '../../../core/audio/audio_queue.dart';
import '../../../core/audio/queue_manager.dart';
import '../../../music/presentation/providers/music_providers.dart';

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
    final ambientColor = palette.vibrantColor ?? palette.dominantColor;

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
                  PlayerTopBar(
                    isLyricsMode: _currentMode == PlayerMode.lyricsFocus,
                    ambientColor: ambientColor,
                    onToggleMode: () {
                      setState(() {
                        _currentMode = _currentMode == PlayerMode.lyricsFocus
                            ? PlayerMode.standard
                            : PlayerMode.lyricsFocus;
                      });
                    },
                  ),
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
                          PlayerProgressBar(ambientColor: ambientColor),
                          const SizedBox(height: AppSpacing.md),
                          PlaybackControls(ambientColor: ambientColor),
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

  void _showQueueSheet(BuildContext context) {
    final notifier = ref.read(playbackSessionProvider.notifier);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StreamBuilder<AudioQueue>(
          stream: QueueManager().onQueueChanged,
          initialData: QueueManager().currentQueue,
          builder: (context, snapshot) {
            final queueObj = snapshot.data ?? QueueManager().currentQueue;
            final queue = queueObj.items;
            final currentSong = ref.watch(currentSongProvider);

            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Play Queue (${queue.length} songs)',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: queue.length,
                          itemBuilder: (context, index) {
                            final song = queue[index];
                            final isPlaying = song.id == currentSong?.id;
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  song.artworkUrl,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.music_note),
                                ),
                              ),
                              title: Text(
                                _cleanText(song.title),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
                                  color: isPlaying ? Theme.of(context).colorScheme.primary : null,
                                ),
                              ),
                              subtitle: Text(
                                _cleanText(song.artist),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: isPlaying
                                  ? Icon(Icons.volume_up, color: Theme.of(context).colorScheme.primary)
                                  : null,
                              onTap: () {
                                notifier.playSong(song, queue: queue, index: index);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPlayerContent(dynamic song) {
    final notifier = ref.read(playbackSessionProvider.notifier);

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -300) {
          // Swipe Up -> Show Queue Sheet
          HapticFeedback.mediumImpact();
          _showQueueSheet(context);
        } else if (details.primaryVelocity! > 300) {
          // Swipe Down -> Go back to previous screen
          HapticFeedback.lightImpact();
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            context.go('/');
          }
        }
      },
      child: _buildPlayerModeBody(song, notifier),
    );
  }

  Widget _buildPlayerModeBody(dynamic song, PlaybackSessionNotifier notifier) {
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
                onSwipeLeft: () => notifier.playNext(),
                onSwipeRight: () => notifier.playPrevious(),
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
                onSwipeLeft: () => notifier.playNext(),
                onSwipeRight: () => notifier.playPrevious(),
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
            _cleanText(song.title),
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
            _cleanText(song.artist),
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

  String _cleanText(String text) {
    return text
        .replaceAll('&amp;quot;', '"')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;#039;', "'")
        .replaceAll('&#039;', "'")
        .replaceAll('&apos;', "'")
        .replaceAll('&#39;', "'")
        .replaceAll('&amp;amp;', '&')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }
}
