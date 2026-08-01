import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../provider/player_provider.dart';
import 'queue_bottom_sheet.dart';
import 'sleep_timer_sheet.dart';
import 'playback_speed_sheet.dart';
import 'audio_quality_sheet.dart';
import '../../../core/widgets/sheets/add_to_playlist_sheet.dart';

class PlayerBottomActions extends ConsumerWidget {
  final VoidCallback onLyricsTap;
  final bool lyricsActive;

  const PlayerBottomActions({
    super.key,
    required this.onLyricsTap,
    required this.lyricsActive,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            Icons.lyrics_rounded,
            color: lyricsActive ? context.colorScheme.primary : null,
          ),
          tooltip: 'Toggle Lyrics Mode',
          onPressed: onLyricsTap,
        ),
        IconButton(
          icon: const Icon(Icons.high_quality_rounded),
          tooltip: 'Music Quality',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const AudioQualitySheet(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.timer_rounded),
          tooltip: 'Sleep Timer',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const SleepTimerSheet(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.speed_rounded),
          tooltip: 'Playback Speed',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const PlaybackSpeedSheet(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.playlist_add_rounded),
          tooltip: 'Add to Playlist',
          onPressed: () {
            final song = ref.read(currentSongProvider);
            if (song != null) {
              showAddToPlaylistSheet(context, song);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.queue_music_rounded),
          tooltip: 'Playing Queue',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const QueueBottomSheet(),
            );
          },
        ),
      ],
    );
  }
}
