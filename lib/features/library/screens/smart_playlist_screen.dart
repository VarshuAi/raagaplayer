import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/library_manager.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/database/app_database.dart' hide Song, Playlist;
import '../../../music/domain/entities/song.dart';
import '../widgets/media_list_item.dart';

final smartPlaylistProvider =
    FutureProvider.family<List<Song>, String>((ref, type) async {
  final db = ref.watch(databaseProvider);
  final manager = LibraryManager(database: db);
  return manager.getSmartPlaylist(type);
});

class SmartPlaylistScreen extends ConsumerWidget {
  final String playlistType;

  const SmartPlaylistScreen({
    super.key,
    required this.playlistType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistAsync = ref.watch(smartPlaylistProvider(playlistType));

    return Scaffold(
      appBar: AppBar(
        title: Text(playlistType),
        backgroundColor: Colors.transparent,
      ),
      body: playlistAsync.when(
        loading: () => const Center(child: RaagaCircularIndicator()),
        error: (err, stack) => RaagaErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(smartPlaylistProvider(playlistType)),
        ),
        data: (songs) {
          if (songs.isEmpty) {
            return const RaagaEmptyState(
              title: 'Empty Smart Playlist',
              description:
                  'No matching tracks found for this catalog filter.',
              icon: Icons.playlist_remove_rounded,
            );
          }

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return MediaListItem(
                title: song.title,
                subtitle: song.artist,
                artworkUrl: song.artworkUrl,
                onTap: () {
                  // Play song details
                },
                onLongPress: () {},
              );
            },
          );
        },
      ),
    );
  }
}
