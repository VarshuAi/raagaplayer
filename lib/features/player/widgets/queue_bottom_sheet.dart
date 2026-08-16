import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/sheets/raaga_bottom_sheet.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../provider/queue_provider.dart';
import '../provider/player_provider.dart';
import '../../../music/presentation/providers/music_providers.dart';
import '../../../core/audio/queue_manager.dart';

class QueueBottomSheet extends ConsumerWidget {
  const QueueBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(queueProvider);
    final currentSong = ref.watch(currentSongProvider);

    final isOnline = currentSong != null && !currentSong.isLocal;

    return RaagaBottomSheet(
      title: 'Play Queue (${queue.length} songs)',
      trailing: isOnline
          ? IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
              tooltip: 'Refresh recommendations',
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refreshing recommendations...'),
                    duration: Duration(seconds: 1),
                  ),
                );
                await ref.read(playbackSessionProvider.notifier).refreshCurrentAutoplayQueue();
              },
            )
          : null,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: queue.isEmpty
            ? const Center(child: Text('Play queue is empty'))
            : ReorderableListView.builder(
                itemCount: queue.length,
                onReorder: (oldIndex, newIndex) {
                  QueueManager().reorder(oldIndex, newIndex);
                },
                itemBuilder: (context, index) {
                  final song = queue[index];
                  final isCurrent = song.id == currentSong?.id;

                  return Dismissible(
                    key: Key('queue_dismiss_${song.id}_$index'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete_rounded, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      QueueManager().remove(index);
                    },
                    child: ListTile(
                      key: Key('queue_tile_${song.id}_$index'),
                      leading: RaagaArtwork(
                        imageUrl: song.artworkUrl,
                        size: 40.0,
                        radius: 8.0,
                      ),
                      title: Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: isCurrent ? context.colorScheme.primary : null,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        song.artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.drag_handle_rounded),
                      onTap: () {
                        ref.read(playbackSessionProvider.notifier).playSong(
                          song,
                          queue: queue,
                          index: index,
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
