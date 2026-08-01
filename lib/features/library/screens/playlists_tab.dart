import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../widgets/media_list_item.dart';
import '../../../core/database/app_database.dart' hide Song, Playlist;
import '../../home/screens/entity_detail_screen.dart';

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

  void _showCreatePlaylistDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Create New Playlist', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Playlist Name',
                  hintText: 'My Favorites, Gym Beats...',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Awesome tracks for coding...',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                final db = ref.read(databaseProvider);
                final id = 'pl_${DateTime.now().millisecondsSinceEpoch}';

                await db.into(db.playlists).insert(
                  PlaylistsCompanion.insert(
                    id: id,
                    name: name,
                    description: Value(descController.text.trim()),
                    creator: 'User',
                  ),
                );

                ref.invalidate(playlistsProvider);
                if (context.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Playlist "$name" created!')),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePlaylistDialog(context, ref),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RaagaEmptyState(
                    title: 'No Playlists Found',
                    description: 'Tap + below to create your first custom playlist.',
                    icon: Icons.playlist_add_rounded,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _showCreatePlaylistDialog(context, ref),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Create Playlist'),
                  ),
                ],
              ),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EntityDetailScreen(
                        entityId: playlist['id'],
                        title: playlist['name'],
                        subtitle: playlist['description'] ?? '',
                        artworkUrl: playlist['artworkUrl'] ?? '',
                        type: 'playlist',
                      ),
                    ),
                  );
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
