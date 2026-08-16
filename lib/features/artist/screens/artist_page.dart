import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../domain/entities/song.dart';
import '../../../music/data/datasource/remote/ytmusic_client.dart';
import '../../../music/presentation/providers/music_providers.dart';
import '../../player/provider/player_provider.dart';

// ── Provider ─────────────────────────────────────────────────────────────────
final artistSongsProvider = FutureProvider.family<List<Song>, String>((ref, artistName) async {
  final httpClient = ref.read(httpClientProvider);

  // Run 2 queries in parallel: top songs + hits
  final results = await Future.wait([
    ytMusicPost('search', {
      'query': '$artistName top songs',
      'params': 'EgWKAQIIAWoKEAMQBBAJEAoQBQ==', // songs filter
    }, client: httpClient),
    ytMusicPost('search', {
      'query': '$artistName best hits',
      'params': 'EgWKAQIIAWoKEAMQBBAJEAoQBQ==',
    }, client: httpClient),
  ]);

  final seen = <String>{};
  final songs = <Song>[];

  for (final data in results) {
    if (data == null) continue;
    final raw = extractSongs(data);
    for (final r in raw) {
      final id = r['id'] as String? ?? '';
      if (id.isEmpty || !seen.add(id)) continue;
      songs.add(Song(
        id: id,
        title: r['title'] as String,
        artist: r['artist'] as String,
        album: '',
        artworkUrl: r['artworkUrl'] as String,
        sourceUrl: '/api/stream?id=$id',
        duration: Duration(seconds: r['durationSeconds'] as int),
        isLocal: false,
        isFavorite: false,
      ));
    }
  }

  return songs.take(20).toList();
});

// ── Screen ────────────────────────────────────────────────────────────────────
class ArtistPage extends ConsumerWidget {
  final String artistName;
  const ArtistPage({super.key, required this.artistName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsAsync = ref.watch(artistSongsProvider(artistName));
    final primary = context.colorScheme.primary;
    final secondary = context.colorScheme.secondary;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero header ────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: context.colorScheme.surface,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          primary.withOpacity(0.55),
                          secondary.withOpacity(0.25),
                          context.colorScheme.surface,
                        ],
                        center: Alignment.topCenter,
                        radius: 1.2,
                      ),
                    ),
                  ),
                  // Animated music equalizer icon
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 36),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [primary, secondary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.5),
                                blurRadius: 28,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            size: 56,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          artistName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 8),
                            ],
                          ),
                        ),
                        Text(
                          'Top Songs',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Song list ──────────────────────────────────────────
          songsAsync.when(
            loading: () => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40),
                    RaagaCircularIndicator(),
                    SizedBox(height: 14),
                    Text('Loading songs...', style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ),
            ),
            error: (e, _) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text('Failed to load: $e', style: const TextStyle(color: Colors.red)),
              ),
            ),
            data: (songs) {
              if (songs.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('No songs found for this artist.')),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      // Play All button
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 4),
                        child: Row(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              onPressed: () {
                                ref.read(playbackSessionProvider.notifier).playSong(
                                  songs.first,
                                  queue: songs,
                                  index: 0,
                                );
                              },
                              icon: const Icon(Icons.play_arrow_rounded, size: 22),
                              label: const Text('Play All', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 10),
                            IconButton.filledTonal(
                              icon: const Icon(Icons.shuffle_rounded),
                              tooltip: 'Shuffle',
                              onPressed: () {
                                final shuffled = List<Song>.from(songs)..shuffle();
                                ref.read(playbackSessionProvider.notifier).playSong(
                                  shuffled.first,
                                  queue: shuffled,
                                  index: 0,
                                );
                              },
                            ),
                            const Spacer(),
                            Text(
                              '${songs.length} songs',
                              style: TextStyle(
                                color: context.colorScheme.onSurface.withOpacity(0.5),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final song = songs[index - 1];
                    return _ArtistSongTile(song: song, songs: songs, index: index - 1);
                  },
                  childCount: songs.length + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Song tile ────────────────────────────────────────────────────────────────
class _ArtistSongTile extends ConsumerWidget {
  final Song song;
  final List<Song> songs;
  final int index;

  const _ArtistSongTile({
    required this.song,
    required this.songs,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: song.artworkUrl.startsWith('http')
            ? Image.network(
                song.artworkUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _fallback(context),
              )
            : _fallback(context),
      ),
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      subtitle: Text(
        song.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          color: context.colorScheme.onSurface.withOpacity(0.55),
        ),
      ),
      trailing: Icon(
        Icons.play_arrow_rounded,
        color: context.colorScheme.onSurface.withOpacity(0.35),
      ),
      onTap: () {
        ref.read(playbackSessionProvider.notifier).playSong(
          song,
          queue: songs,
          index: index,
        );
      },
    );
  }

  Widget _fallback(BuildContext context) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              context.colorScheme.secondary,
              context.colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 24),
      );
}
