import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../provider/lyrics_provider.dart';
import '../provider/playback_provider.dart';

class LyricsPanel extends ConsumerStatefulWidget {
  const LyricsPanel({super.key});

  @override
  ConsumerState<LyricsPanel> createState() => _LyricsPanelState();
}

class _LyricsPanelState extends ConsumerState<LyricsPanel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(playbackPositionProvider).value ?? Duration.zero;
    final lyricsNotifier = ref.watch(lyricsProvider); // Lyrics state manager
    final engine = ref.watch(audioEngineProvider);

    // Auto-scroll lyrics callback as index increments
    final lyrics = lyricsNotifier.lyrics;
    final activeIndex = lyricsNotifier.currentLineIndex;

    // Load mock synced lyrics for testing if empty
    if (lyrics.isEmpty) {
      ref.read(lyricsProvider).loadLyrics([
        LyricLine(const Duration(seconds: 0), "Intro (Instrumental)"),
        LyricLine(const Duration(seconds: 5), "Welcome to Raaga Premium Player"),
        LyricLine(const Duration(seconds: 12), "Experience the smooth Material 3 visual curves"),
        LyricLine(const Duration(seconds: 20), "Listening to local scanned library audio tracks"),
        LyricLine(const Duration(seconds: 28), "Frosted glass container layers blending dynamically"),
        LyricLine(const Duration(seconds: 35), "Enjoy gapless local files playback indexing"),
        LyricLine(const Duration(seconds: 44), "Outro (Instrumental fading out...)"),
      ]);
    }

    // Trigger updates on playback position shifts
    ref.read(lyricsProvider).updatePosition(position);

    if (lyrics.isEmpty) {
      return const Center(child: Text("Lyrics not available"));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
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
                color: isActive ? context.colorScheme.primary : context.colorScheme.onSurface.withOpacity(0.38),
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                fontSize: isActive ? 24 : 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
