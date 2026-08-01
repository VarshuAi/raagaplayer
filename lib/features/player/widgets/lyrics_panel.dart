import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../core/extensions/context_extensions.dart';
import '../../../core/database/app_database.dart';
import '../../../music/presentation/providers/music_providers.dart';
import '../../lyrics/data/services/lyrics_service.dart';
import '../provider/lyrics_provider.dart';
import '../provider/playback_provider.dart';
import '../provider/player_provider.dart';
import '../provider/artwork_provider.dart';

class LyricsPanel extends ConsumerStatefulWidget {
  const LyricsPanel({super.key});

  @override
  ConsumerState<LyricsPanel> createState() => _LyricsPanelState();
}

class _LyricsPanelState extends ConsumerState<LyricsPanel> {
  final ScrollController _scrollController = ScrollController();
  String? _lastLoadedSongId;
  bool _isLoading = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadSongLyrics(dynamic song) async {
    if (song == null || song.id == _lastLoadedSongId || _isLoading) return;
    _lastLoadedSongId = song.id;
    setState(() => _isLoading = true);

    try {
      final db = ref.read(databaseProvider);
      final service = LyricsService(database: db, httpClient: http.Client());
      final lyricsData = await service.getLyrics(
        songId: song.id,
        title: song.title,
        artist: song.artist,
      );

      if (mounted) {
        ref.read(lyricsProvider).loadLyrics(lyricsData.lines);
        setState(() => _isLoading = false);
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = ref.watch(currentSongProvider);
    final position = ref.watch(playbackPositionProvider).value ?? Duration.zero;
    final lyricsNotifier = ref.watch(lyricsProvider);
    final engine = ref.watch(audioEngineProvider);
    final palette = ref.watch(artworkPaletteProvider);
    final ambientColor = palette.vibrantColor ?? palette.dominantColor;

    if (currentSong != null && currentSong.id != _lastLoadedSongId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadSongLyrics(currentSong);
      });
    }

    final lyrics = lyricsNotifier.lyrics;
    final activeIndex = lyricsNotifier.currentLineIndex;

    ref.read(lyricsProvider).updatePosition(position);

    return Column(
      children: [
        const SizedBox(height: 12),
        Expanded(
          child: _isLoading && lyrics.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : lyrics.isEmpty
                  ? Center(
                      child: Text(
                        "Lyrics not available for this track",
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                      itemCount: lyrics.length,
                      itemBuilder: (context, index) {
                        final line = lyrics[index];
                        final isActive = index == activeIndex;

                        return GestureDetector(
                          onTap: () {
                            engine.seek(line.timeStamp);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              line.text,
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineSmall?.copyWith(
                                color: isActive
                                    ? ambientColor
                                    : context.colorScheme.onSurface.withOpacity(0.38),
                                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                                fontSize: isActive ? 24 : 18,
                                shadows: isActive
                                    ? [
                                        Shadow(
                                          color: ambientColor.withOpacity(0.5),
                                          blurRadius: 16,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
