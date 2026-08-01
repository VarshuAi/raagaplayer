import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/menus/raaga_context_menu.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/audio/queue_manager.dart';
import '../../../domain/entities/song.dart';
import '../widgets/media_list_item.dart';
import '../../../core/database/app_database.dart' hide Song, Playlist;
import '../../player/provider/playback_provider.dart';
import '../../player/provider/player_provider.dart';
import '../../../music/presentation/providers/music_providers.dart';

class SongsTab extends ConsumerStatefulWidget {
  const SongsTab({super.key});

  @override
  ConsumerState<SongsTab> createState() => _SongsTabState();
}

class _SongsTabState extends ConsumerState<SongsTab> {
  bool _isGridView = false;
  String _sortBy = 'title'; // 'title', 'artist', 'duration'

  @override
  Widget build(BuildContext context) {
    final songsAsync = ref.watch(homeSongsProvider);

    return Scaffold(
      body: Column(
        children: [
          // Filter & Display toggles bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _sortBy,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  underline: const SizedBox(),
                  onChanged: (val) {
                    if (val != null) setState(() => _sortBy = val);
                  },
                  items: const [
                    DropdownMenuItem(value: 'title', child: Text('Sort by Name')),
                    DropdownMenuItem(value: 'artist', child: Text('Sort by Artist')),
                    DropdownMenuItem(value: 'duration', child: Text('Sort by Duration')),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(_isGridView ? Icons.list_rounded : Icons.grid_view_rounded),
                  onPressed: () => setState(() => _isGridView = !_isGridView),
                ),
              ],
            ),
          ),
          Expanded(
            child: songsAsync.when(
              loading: () => const Center(child: RaagaCircularIndicator()),
              error: (err, stack) => RaagaErrorState(
                message: err.toString(),
                onRetry: () => ref.invalidate(homeSongsProvider),
              ),
              data: (songs) {
                if (songs.isEmpty) {
                  return const RaagaEmptyState(
                    title: 'No Local Songs Scanned',
                    description: 'Run media scanner in settings to populate the library.',
                    icon: Icons.music_note_rounded,
                  );
                }

                // Apply sorting
                final sortedSongs = List<Song>.from(songs);
                if (_sortBy == 'title') {
                  sortedSongs.sort((a, b) => a.title.compareTo(b.title));
                } else if (_sortBy == 'artist') {
                  sortedSongs.sort((a, b) => a.artist.compareTo(b.artist));
                } else if (_sortBy == 'duration') {
                  sortedSongs.sort((a, b) => a.duration.compareTo(b.duration));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(homeSongsProvider);
                  },
                  child: _isGridView
                      ? _buildGrid(sortedSongs)
                      : _buildList(sortedSongs),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Song> songs) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return MediaListItem(
          title: song.title,
          subtitle: '${song.artist} • ${song.album}',
          artworkUrl: song.artworkUrl,
          heroTag: 'library_list_art_${song.id}',
          onTap: () => _playSong(song),
          onLongPress: () => _showContextMenu(song),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () => _showContextMenu(song),
          ),
        );
      },
    );
  }

  Widget _buildGrid(List<Song> songs) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return Card(
          child: InkWell(
            onTap: () => _playSong(song),
            onLongPress: () => _showContextMenu(song),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      song.artworkUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.music_note, size: 64),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(song.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(song.artist, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _playSong(Song song) {
    ref.read(currentSongProvider.notifier).state = song;
    ref.read(audioEngineProvider).setSource(song.sourceUrl).then((_) {
      ref.read(audioEngineProvider).play();
    });
  }

  void _showContextMenu(Song song) {
    RaagaContextMenu.show(
      context: context,
      title: song.title,
      subtitle: song.artist,
      options: [
        RaagaContextMenuOption(
          icon: Icons.play_arrow_rounded,
          label: 'Play Now',
          onTap: () => _playSong(song),
        ),
        RaagaContextMenuOption(
          icon: Icons.playlist_play_rounded,
          label: 'Play Next',
          onTap: () => QueueManager().insertNext(song),
        ),
        RaagaContextMenuOption(
          icon: Icons.queue_music_rounded,
          label: 'Add to Queue',
          onTap: () => QueueManager().add(song),
        ),
      ],
    );
  }
}
