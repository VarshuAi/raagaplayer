import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/database/app_database.dart' hide Song, Playlist;
import '../widgets/media_list_item.dart';

final albumsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final db = ref.watch(databaseProvider);
  final list = await db.select(db.albums).get();
  return list.map((a) => {
    'name': a.name,
    'artist': a.artist,
    'artworkUrl': a.artworkUrl ?? '',
    'songCount': a.songCount,
  }).toList();
});

class AlbumsTab extends ConsumerWidget {
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(albumsProvider);

    return Scaffold(
      body: albumsAsync.when(
        loading: () => const Center(child: RaagaCircularIndicator()),
        error: (err, stack) => RaagaErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(albumsProvider),
        ),
        data: (albums) {
          if (albums.isEmpty) {
            return const RaagaEmptyState(
              title: 'No Albums Found',
              description: 'Scanned local songs will group albums automatically.',
              icon: Icons.album_rounded,
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.8,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return InkWell(
                onTap: () {
                  // Navigate to Album Songs view
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RaagaArtwork(
                        imageUrl: album['artworkUrl'],
                        size: double.infinity,
                        radius: 12.0,
                        heroTag: 'album_art_${album['name']}',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      album['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      album['artist'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.50),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
