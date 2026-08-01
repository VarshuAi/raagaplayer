import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/extensions/context_extensions.dart';
import '../../../core/database/app_database.dart' as db_models;
import '../provider/player_provider.dart';
import '../../download/data/services/download_manager.dart';
import '../../../music/presentation/providers/music_providers.dart';
import '../../settings/provider/settings_provider.dart';
import 'audio_quality_sheet.dart';
import '../../../core/widgets/sheets/add_to_playlist_sheet.dart';

class PlayerTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isLyricsMode;
  final VoidCallback onToggleMode;
  final Color? ambientColor;

  const PlayerTopBar({
    super.key,
    required this.isLyricsMode,
    required this.onToggleMode,
    this.ambientColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongProvider);
    final settings = ref.watch(settingsProvider);
    final activeColor = ambientColor ?? context.colorScheme.primary;

    final qualityTag = settings.audioQuality == '320kbps'
        ? '320k HD'
        : settings.audioQuality == '160kbps'
            ? '160k'
            : '96k';

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Container(
        height: 34,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHigh.withOpacity(0.6),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: isLyricsMode ? onToggleMode : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: !isLyricsMode ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'Song',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: !isLyricsMode ? Colors.white : context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: !isLyricsMode ? onToggleMode : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isLyricsMode ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'Lyrics',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isLyricsMode ? Colors.white : context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const AudioQualitySheet(),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: activeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: activeColor.withOpacity(0.6),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.high_quality_rounded,
                  size: 14,
                  color: activeColor,
                ),
                const SizedBox(width: 4),
                Text(
                  qualityTag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: activeColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.download_for_offline_rounded),
          tooltip: 'Download Track',
          onPressed: () {
            if (song != null) {
              DownloadManager().startDownload(
                song.id,
                'raaga_stream',
                song.sourceUrl,
                songTitle: song.title,
                artistName: song.artist,
                artworkUrl: song.artworkUrl,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Downloading "${song.title}"...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.playlist_add_rounded),
          tooltip: 'Add to Playlist',
          onPressed: () {
            if (song != null) {
              showAddToPlaylistSheet(context, song);
            }
          },
        ),
        IconButton(
          icon: Icon(
            song?.isFavorite == true ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: song?.isFavorite == true ? activeColor : null,
          ),
          onPressed: () async {
            if (song != null) {
              final newFav = !song.isFavorite;
              final updatedSong = song.copyWith(isFavorite: newFav);
              ref.read(currentSongProvider.notifier).state = updatedSong;

              final db = ref.read(db_models.databaseProvider);
              await db.into(db.songs).insertOnConflictUpdate(
                db_models.SongsCompanion(
                  id: Value(song.id),
                  title: Value(song.title),
                  artist: Value(song.artist),
                  album: Value(song.album),
                  duration: Value('${song.duration.inSeconds}s'),
                  durationMs: Value(song.duration.inMilliseconds),
                  path: Value(song.sourceUrl),
                  folder: const Value('online'),
                  artworkUrl: Value(song.artworkUrl),
                  isFavorite: Value(newFav),
                  isLocal: Value(song.isLocal),
                ),
              );

              ref.invalidate(favoritesSongsProvider);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(newFav ? 'Added "${song.title}" to Favorites' : 'Removed from Favorites'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
