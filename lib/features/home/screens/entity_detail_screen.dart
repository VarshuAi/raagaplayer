import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/constants/urls.dart';
import '../../../domain/entities/song.dart';
import '../../../music/presentation/providers/music_providers.dart';
import '../../player/provider/player_provider.dart';

class EntityDetailScreen extends ConsumerStatefulWidget {
  final String entityId;
  final String title;
  final String subtitle;
  final String artworkUrl;
  final String type; // 'playlist', 'album', 'chart'

  const EntityDetailScreen({
    super.key,
    required this.entityId,
    required this.title,
    required this.subtitle,
    required this.artworkUrl,
    required this.type,
  });

  @override
  ConsumerState<EntityDetailScreen> createState() => _EntityDetailScreenState();
}

class _EntityDetailScreenState extends ConsumerState<EntityDetailScreen> {
  final List<Song> _tracks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTracks();
  }

  Future<void> _fetchTracks() async {
    try {
      final client = ref.read(httpClientProvider);
      Uri uri;
      if (widget.type == 'radio') {
        final query = widget.title.isNotEmpty ? widget.title : widget.subtitle;
        uri = Uri.parse('${AppUrls.baseApiUrl}/api/search/songs?query=${Uri.encodeComponent(query)}&page=1&limit=30');
      } else {
        final endpoint = widget.type == 'playlist' ? 'playlist' : 'album';
        uri = Uri.parse('${AppUrls.baseApiUrl}/api/$endpoint/${widget.entityId}');
      }
      print('Fetching Entity Tracks from: $uri');

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> songList = data['results'] ?? data['songs'] ?? data['tracks'] ?? data['list'] ?? (data is List ? data : []);

        final parsed = songList.map((s) {
          final rawArtwork = s['artworkUrl'] ?? s['image'] ?? s['coverUrl'] ?? widget.artworkUrl;
          String rawStreamUrl = (s['streamingUrl'] ?? s['sourceUrl'] ?? s['streamUrl'] ?? s['media_url'] ?? '').toString();
          final songId = (s['id'] ?? s['songid'] ?? '').toString();
          if (rawStreamUrl.isEmpty && songId.isNotEmpty) {
            rawStreamUrl = '/api/song/$songId/stream-url';
          }

          String fullStreamUrl = rawStreamUrl.toString();
          if (fullStreamUrl.startsWith('/')) {
            fullStreamUrl = '${AppUrls.baseApiUrl}$fullStreamUrl';
          }

          return Song(
            id: songId,
            title: _cleanText((s['title'] ?? s['song'] ?? s['name'] ?? 'Unknown Track').toString()),
            artist: _cleanText((s['artist'] ?? s['singers'] ?? s['primary_artists'] ?? widget.subtitle).toString()),
            album: _cleanText((s['album'] ?? widget.title).toString()),
            artworkUrl: rawArtwork.toString().replaceAll('150x150', '500x500'),
            sourceUrl: fullStreamUrl,
            duration: Duration(seconds: s['duration'] is int ? s['duration'] : 180),
            isLocal: false,
            isFavorite: false,
          );
        }).where((s) => s.id.isNotEmpty).toList();

        if (mounted) {
          setState(() {
            _tracks.clear();
            _tracks.addAll(parsed);
            _isLoading = false;
          });
        }
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Entity Track Fetch Error: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: context.colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.artworkUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: context.colorScheme.surfaceContainerHigh),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        margin: const EdgeInsets.only(top: 8, left: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.music_note_rounded, color: Colors.white, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'A1 RAAGA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          context.colorScheme.surface.withOpacity(0.85),
                          context.colorScheme.surface,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.70),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                      label: const Text(
                        'Play All',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () {
                        if (_tracks.isNotEmpty) {
                          ref.read(playbackSessionProvider.notifier).playSong(
                            _tracks.first,
                            queue: _tracks,
                            index: 0,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  IconButton(
                    icon: const Icon(Icons.shuffle_rounded),
                    onPressed: () {
                      if (_tracks.isNotEmpty) {
                        final shuffled = List<Song>.from(_tracks)..shuffle();
                        ref.read(playbackSessionProvider.notifier).playSong(
                          shuffled.first,
                          queue: shuffled,
                          index: 0,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_tracks.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text('No tracks available in this playlist/album'),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final song = _tracks[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        song.artworkUrl,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.music_note_rounded),
                      ),
                    ),
                    title: Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(song.artist),
                    onTap: () {
                      ref.read(playbackSessionProvider.notifier).playSong(
                        song,
                        queue: _tracks,
                        index: index,
                      );
                    },
                  );
                },
                childCount: _tracks.length,
              ),
            ),
        ],
      ),
    );
  }

  String _cleanText(String text) {
    return text
        .replaceAll('&amp;quot;', '"')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;#039;', "'")
        .replaceAll('&#039;', "'")
        .replaceAll('&apos;', "'")
        .replaceAll('&#39;', "'")
        .replaceAll('&amp;amp;', '&')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }
}
