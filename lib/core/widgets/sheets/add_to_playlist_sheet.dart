import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/song.dart';
import '../../../music/presentation/providers/music_providers.dart';
import '../../database/app_database.dart' hide Song;
import '../../design_tokens/spacing.dart';
import '../../extensions/context_extensions.dart';

void showAddToPlaylistSheet(BuildContext context, Song song) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddToPlaylistSheet(song: song),
  );
}

class AddToPlaylistSheet extends ConsumerStatefulWidget {
  final Song song;
  const AddToPlaylistSheet({super.key, required this.song});

  @override
  ConsumerState<AddToPlaylistSheet> createState() => _AddToPlaylistSheetState();
}

class _AddToPlaylistSheetState extends ConsumerState<AddToPlaylistSheet> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _loadPlaylists() async {
    final db = ref.read(databaseProvider);
    final rows = await db.select(db.playlists).get();
    final List<Map<String, dynamic>> list = [];
    for (final row in rows) {
      final songsCount = await (db.select(db.playlistSongs)
            ..where((t) => t.playlistId.equals(row.id)))
          .get();
      list.add({
        'id': row.id,
        'name': row.name,
        'count': songsCount.length,
        'artworkUrl': row.artworkUrl ?? '',
      });
    }
    return list;
  }

  Future<void> _addSongToPlaylist(String playlistId, String playlistName) async {
    final db = ref.read(databaseProvider);
    // 1. Ensure song is saved in SQLite songs table
    final minutes = widget.song.duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = widget.song.duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    await db.customStatement('''
      INSERT OR REPLACE INTO songs (id, title, artist, album, duration, path, folder, artwork_url, is_local, is_favorite)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    ''', [
      widget.song.id,
      widget.song.title,
      widget.song.artist,
      widget.song.album,
      '$minutes:$seconds',
      widget.song.sourceUrl,
      'Online Stream',
      widget.song.artworkUrl,
      widget.song.isLocal ? 1 : 0,
      widget.song.isFavorite ? 1 : 0
    ]);

    // 2. Insert into playlist_songs table
    final count = (await (db.select(db.playlistSongs)..where((t) => t.playlistId.equals(playlistId))).get()).length;
    await db.customStatement('''
      INSERT OR REPLACE INTO playlist_songs (playlist_id, song_id, sequence)
      VALUES (?, ?, ?);
    ''', [playlistId, widget.song.id, count + 1]);

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added "${widget.song.title}" to "$playlistName"'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _showCreatePlaylistDialog() async {
    _nameController.clear();
    return showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: context.colorScheme.surfaceContainerHigh,
        title: const Text('New Playlist'),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Playlist Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              if (name.isNotEmpty) {
                Navigator.pop(dialogCtx);
                final db = ref.read(databaseProvider);
                final newId = 'pl_${DateTime.now().millisecondsSinceEpoch}';
                await db.customStatement('''
                  INSERT INTO playlists (id, name, description, artwork_url, creator)
                  VALUES (?, ?, ?, ?, ?);
                ''', [newId, name, 'Custom Playlist', widget.song.artworkUrl, 'User']);

                await _addSongToPlaylist(newId, name);
              }
            },
            child: const Text('Create & Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add to Playlist',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: context.colorScheme.primary.withOpacity(0.15),
              child: Icon(Icons.add_rounded, color: context.colorScheme.primary),
            ),
            title: const Text('Create New Playlist', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: _showCreatePlaylistDialog,
          ),
          const Divider(),
          Flexible(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _loadPlaylists(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final playlists = snapshot.data ?? [];

                if (playlists.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Text('No custom playlists yet. Create one above!'),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final pl = playlists[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.playlist_play_rounded, color: context.colorScheme.primary),
                      ),
                      title: Text(pl['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${pl['count']} tracks'),
                      onTap: () => _addSongToPlaylist(pl['id'] as String, pl['name'] as String),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
