import 'dart:math';
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

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

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
          style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
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
            return const RaagaEmptyState(
              title: 'No Songs Available',
              description: 'Use the library tab to scan your local storage.',
              icon: Icons.music_library_rounded,
            );
          }

          final favorites = songs.where((s) => s.isFavorite).toList();
          final randomMix = List<Song>.from(songs)..shuffle(Random(42));
          final recentlyAdded = List<Song>.from(songs).reversed.take(8).toList();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDynamicShelf('Continue Listening', 'Pick up where you left off', songs.take(5).toList()),
                _buildDynamicShelf('Recently Played', 'Tracks you listened to recently', songs.take(6).toList()),
                _buildDynamicShelf('Recently Added', 'Latest additions to your catalog', recentlyAdded),
                if (favorites.isNotEmpty)
                  _buildDynamicShelf('Favorites', 'Your personal catalog highlights', favorites),
                _buildDynamicShelf('Random Mix', 'A shuffled selection just for you', randomMix.take(10).toList()),
                _buildDynamicShelf('On This Device', 'All local tracks found', songs),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDynamicShelf(String title, String subtitle, List<Song> items) {
    return RaagaShelfWidget(
      title: title,
      subtitle: subtitle,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final song = items[index];
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
                  heroTag: 'home_${title.replaceAll(' ', '_')}_${song.id}',
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
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
      },
    );
  }
}
