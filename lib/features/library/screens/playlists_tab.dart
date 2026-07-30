import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../widgets/media_list_item.dart';
import '../../home/screens/home_screen.dart';

final playlistsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final db = ref.watch(databaseProvider);
  final list = await db.select(db.playlists).get();
  return list.map((p) => {
    'id': p.id,
    'name': p.name,
    'description': p.description ?? '',
    'artworkUrl': p.artworkUrl ?? '',
    'creator': p.creator,
  }).toList();
});

class PlaylistsTab extends ConsumerWidget {
  const PlaylistsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger create playlist bottom sheet
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: playlistsAsync.when(
        loading: () => const Center(child: RaagaCircularIndicator()),
        error: (err, stack) => RaagaErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(playlistsProvider),
        ),
        data: (playlists) {
          if (playlists.isEmpty) {
            return const RaagaEmptyState(
              title: 'No Playlists Found',
              description: 'Create custom playlists to group songs together.',
              icon: Icons.playlist_add_rounded,
            );
          }

          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return MediaListItem(
                title: playlist['name'],
                subtitle: playlist['description'] ?? 'Custom playlist',
                artworkUrl: playlist['artworkUrl'],
                heroTag: 'playlist_art_${playlist['id']}',
                onTap: () {
                  // Navigate to Playlist detail track list
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
