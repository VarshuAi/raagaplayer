import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../../../core/widgets/cards/raaga_cards.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/song.dart';
import '../widgets/shelf_widget.dart';
import '../../player/provider/playback_provider.dart';
import '../../player/provider/player_provider.dart';

// Database Provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// Home page data fetch providers
final homeSongsProvider = FutureProvider<List<Song>>((ref) async {
  final db = ref.watch(databaseProvider);
  final list = await db.select(db.songs).get();
  return list
      .map((s) => Song(
            id: s.id,
            title: s.title,
            artist: s.artist,
            album: s.album,
            artworkUrl: s.artworkUrl ?? '',
            sourceUrl: s.path,
            duration: Duration(milliseconds: s.durationMs ?? 0),
            isLocal: s.isLocal,
            isFavorite: s.isFavorite,
          ))
      .toList();
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final songsAsync = ref.watch(homeSongsProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Raaga',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: songsAsync.when(
        loading: () => const Center(child: RaagaCircularIndicator()),
        error: (err, stack) => RaagaErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(homeSongsProvider),
        ),
        data: (songs) {
          if (songs.isEmpty) {
            return RaagaEmptyState(
              title: 'No Songs Available',
              description: 'Please scan local storage to index your music catalog.',
              icon: Icons.music_library_rounded,
              actionText: 'Scan Storage',
              onActionTap: () {
                // Navigate to library scan tab
              },
            );
          }

          final recent = songs.take(8).toList();
          final favorites = songs.where((s) => s.isFavorite).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Continue Listening / Recently Played
                RaagaShelfWidget(
                  title: 'Continue Listening',
                  subtitle: 'Pick up where you left off',
                  itemCount: recent.length,
                  itemBuilder: (context, index) {
                    final song = recent[index];
                    return _buildSongCard(context, song);
                  },
                ),

                // Favorites Shelf
                if (favorites.isNotEmpty)
                  RaagaShelfWidget(
                    title: 'Favorites',
                    subtitle: 'Your personal collection',
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final song = favorites[index];
                      return _buildSongCard(context, song);
                    },
                  ),

                // All Device Songs Shelf
                RaagaShelfWidget(
                  title: 'On This Device',
                  subtitle: 'Tracks indexed in local folders',
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return _buildSongCard(context, song);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSongCard(BuildContext context, Song song) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: RaagaCard(
        width: 140.0,
        surfaceLevel: 2,
        padding: const EdgeInsets.all(AppSpacing.sm),
        onTap: () {
          ref.read(currentSongProvider.notifier).state = song;
          ref.read(audioEngineProvider).setSource(song.sourceUrl).then((_) {
            ref.read(audioEngineProvider).play();
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaagaArtwork(
              imageUrl: song.artworkUrl,
              size: 120.0,
              radius: 12.0,
              heroTag: 'home_art_${song.id}',
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              song.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              song.artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
