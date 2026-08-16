import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/database/app_database.dart' hide Song;
import '../../../domain/entities/song.dart';
import '../../download/data/services/download_manager.dart';
import '../../../music/presentation/providers/music_providers.dart';

final downloadedSongsProvider = FutureProvider.autoDispose<List<Song>>((ref) async {
  final db = ref.read(databaseProvider);
  final downloadRows = await (db.select(db.downloads)..where((t) => t.status.equals(2))).get();

  final songRows = await db.select(db.songs).get();
  final songMap = {for (var s in songRows) s.id: s};

  final downloadedSongs = <Song>[];
  for (final row in downloadRows) {
    final songId = row.songId;
    final dbSong = songMap[songId];
    if (dbSong != null) {
      downloadedSongs.add(Song(
        id: dbSong.id,
        title: dbSong.title,
        artist: dbSong.artist,
        album: dbSong.album,
        artworkUrl: dbSong.artworkUrl ?? '',
        sourceUrl: row.path ?? '',
        duration: Duration(seconds: dbSong.durationMs != null ? (dbSong.durationMs! / 1000).round() : 180),
        isLocal: true,
        isFavorite: dbSong.isFavorite,
      ));
    }
  }
  return downloadedSongs;
});

class DownloadsTab extends ConsumerWidget {
  const DownloadsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadsAsync = ref.watch(downloadedSongsProvider);

    return downloadsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(
        child: Text(
          'Failed to load downloads',
          style: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.6)),
        ),
      ),
      data: (songs) {
        if (songs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download_for_offline_outlined,
                  size: 64,
                  color: context.colorScheme.onSurface.withOpacity(0.4),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Downloads Yet',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Download tracks to listen to them offline.',
                  style: TextStyle(
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: song.artworkUrl.isNotEmpty && File(song.artworkUrl).existsSync()
                    ? Image.file(
                        File(song.artworkUrl),
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildFallbackIcon(context),
                      )
                    : _buildFallbackIcon(context),
              ),
              title: Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${song.artist} • ${song.album}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                tooltip: 'Delete Download',
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Download?'),
                      content: Text('Are you sure you want to delete "${song.title}" from offline storage?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: TextButton.styleFrom(foregroundColor: Colors.red),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await DownloadManager().deleteDownload(song.id);
                    ref.invalidate(downloadedSongsProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Deleted "${song.title}"')),
                      );
                    }
                  }
                },
              ),
              onTap: () {
                ref.read(playbackSessionProvider.notifier).playSong(
                      song,
                      queue: songs,
                      index: index,
                    );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFallbackIcon(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      color: context.colorScheme.surfaceContainerHigh,
      child: const Icon(Icons.music_note_rounded),
    );
  }
}
