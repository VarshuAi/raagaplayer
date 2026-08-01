import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/design_tokens/spacing.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/database/app_database.dart' hide Song, Playlist;
import '../../../../domain/entities/song.dart';
import '../../data/services/download_manager.dart';
import '../../../../music/presentation/providers/music_providers.dart';
import '../../../player/provider/player_provider.dart';

class DownloadManagerScreen extends ConsumerStatefulWidget {
  const DownloadManagerScreen({super.key});

  @override
  ConsumerState<DownloadManagerScreen> createState() => _DownloadManagerScreenState();
}

class _DownloadManagerScreenState extends ConsumerState<DownloadManagerScreen> {
  int _downloadedCount = 0;
  double _usedStorageMb = 0.0;
  List<Song> _downloadedSongsList = [];
  bool _isAscending = true;
  String _filterQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadRealStorageData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRealStorageData() async {
    try {
      final db = ref.read(databaseProvider);
      final downloadRows = await (db.select(db.downloads)..where((t) => t.status.equals(2))).get();

      final docDir = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory('${docDir.path}/downloads');

      double totalBytes = 0.0;
      if (await downloadsDir.exists()) {
        final files = downloadsDir.listSync(recursive: true);
        for (final file in files) {
          if (file is File) {
            totalBytes += await file.length();
          }
        }
      }

      final songRows = await db.select(db.songs).get();
      final songMap = {for (var s in songRows) s.id: s};

      final downloadedSongs = <Song>[];
      for (final row in downloadRows) {
        final songId = row.songId;
        final dbSong = songMap[songId];
        if (dbSong != null) {
          downloadedSongs.add(Song(
            id: dbSong.id,
            title: dbSong.title,
            artist: dbSong.artist,
            album: dbSong.album,
            artworkUrl: dbSong.artworkUrl ?? '',
            sourceUrl: row.path ?? '',
            duration: Duration(seconds: 210),
            isLocal: true,
            isFavorite: dbSong.isFavorite,
          ));
        }
      }

      setState(() {
        _downloadedCount = downloadRows.length;
        _usedStorageMb = totalBytes / (1024 * 1024);
        _downloadedSongsList = downloadedSongs;
      });
    } catch (_) {}
  }

  void _sortSongs() {
    setState(() {
      _isAscending = !_isAscending;
      if (_isAscending) {
        _downloadedSongsList.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      } else {
        _downloadedSongsList.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
      }
    });
  }

  void _playAll() {
    if (_downloadedSongsList.isNotEmpty) {
      ref.read(playbackSessionProvider.notifier).playSong(
        _downloadedSongsList.first,
        queue: _downloadedSongsList,
        index: 0,
      );
    }
  }

  void _shuffleAll() {
    if (_downloadedSongsList.isNotEmpty) {
      final list = List<Song>.from(_downloadedSongsList)..shuffle();
      ref.read(playbackSessionProvider.notifier).playSong(
        list.first,
        queue: list,
        index: 0,
      );
    }
  }

  Future<void> _deleteTrack(Song song) async {
    await DownloadManager().deleteDownload(song.id);
    await _loadRealStorageData();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted "${song.title}" from downloads')),
      );
    }
  }

  Widget _buildArtworkThumbnail(String artworkUrl) {
    if (artworkUrl.isNotEmpty) {
      final file = File(artworkUrl);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallbackArtwork(),
        );
      } else if (artworkUrl.startsWith('http')) {
        return Image.network(
          artworkUrl,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallbackArtwork(),
        );
      }
    }
    return _buildFallbackArtwork();
  }

  Widget _buildFallbackArtwork() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.secondary,
            context.colorScheme.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(
        Icons.music_note_rounded,
        color: Colors.white,
        size: 26,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredSongs = _filterQuery.isEmpty
        ? _downloadedSongsList
        : _downloadedSongsList.where((s) {
            return s.title.toLowerCase().contains(_filterQuery.toLowerCase()) ||
                s.artist.toLowerCase().contains(_filterQuery.toLowerCase());
          }).toList();

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 310.0,
            floating: false,
            pinned: true,
            backgroundColor: context.colorScheme.surface,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.center,
                children: [
                  // Glowing Raaga App Logo Banner
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          context.colorScheme.primary.withOpacity(0.35),
                          context.colorScheme.surface,
                        ],
                        radius: 0.95,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 36),
                      // Large Raaga Logo Header Artwork
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              context.colorScheme.secondary,
                              context.colorScheme.primary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.primary.withOpacity(0.5),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
                              ),
                            ),
                            const Icon(
                              Icons.download_for_offline_rounded,
                              size: 72,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Downloads',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'offline playlist • ${_usedStorageMb.toStringAsFixed(1)} MB used',
                        style: TextStyle(
                          color: context.colorScheme.onSurface.withOpacity(0.55),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: _loadRealStorageData,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
              child: Column(
                children: [
                  // Action Buttons Row (Play All, Shuffle, Sort)
                  Row(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        onPressed: _playAll,
                        icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
                        label: const Text(
                          'Play All',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton.filledTonal(
                        icon: const Icon(Icons.shuffle_rounded),
                        onPressed: _shuffleAll,
                        tooltip: 'Shuffle Play',
                      ),
                      IconButton.filledTonal(
                        icon: const Icon(Icons.sort_by_alpha_rounded),
                        onPressed: _sortSongs,
                        tooltip: 'Sort List',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sub-header Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${filteredSongs.length} 🎵 • ${_isAscending ? "A-Z" : "Z-A"}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface.withOpacity(0.70),
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        icon: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
                        onPressed: () {
                          setState(() {
                            _isSearching = !_isSearching;
                            if (!_isSearching) {
                              _searchController.clear();
                              _filterQuery = '';
                            }
                          });
                        },
                      ),
                    ],
                  ),

                  if (_isSearching) ...[
                    const SizedBox(height: 8),
                    TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _filterQuery = val;
                        });
                      },
                      style: TextStyle(color: context.colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: 'Filter downloaded songs...',
                        hintStyle: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.4)),
                        prefixIcon: const Icon(Icons.search_rounded),
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerHigh,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Active Downloads Stream Widget
                  StreamBuilder<Map<String, double>>(
                    stream: DownloadManager().progressStream,
                    builder: (context, snapshot) {
                      final progressMap = snapshot.data ?? {};
                      if (progressMap.isEmpty) return const SizedBox.shrink();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Downloading Now',
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...progressMap.entries.map((e) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.downloading_rounded, color: Colors.purpleAccent),
                                title: Text('Downloading track #${e.key}', style: const TextStyle(fontSize: 14)),
                                subtitle: LinearProgressIndicator(
                                  value: e.value,
                                  color: context.colorScheme.primary,
                                ),
                                trailing: Text('${(e.value * 100).toInt()}%'),
                              ),
                            );
                          }),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Downloaded Song List
          filteredSongs.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_done_rounded,
                          size: 64,
                          color: context.colorScheme.onSurface.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Downloaded Songs Yet',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Download songs to listen offline anytime!',
                          style: TextStyle(
                            color: context.colorScheme.onSurface.withOpacity(0.4),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final song = filteredSongs[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 4),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _buildArtworkThumbnail(song.artworkUrl),
                          ),
                          title: Text(
                            song.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          subtitle: Text(
                            song.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.colorScheme.onSurface.withOpacity(0.60),
                              fontSize: 12,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '3:30',
                                style: TextStyle(
                                  color: context.colorScheme.onSurface.withOpacity(0.4),
                                  fontSize: 12,
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  color: context.colorScheme.onSurface.withOpacity(0.6),
                                ),
                                onSelected: (val) {
                                  if (val == 'delete') {
                                    _deleteTrack(song);
                                  } else if (val == 'play') {
                                    ref.read(playbackSessionProvider.notifier).playSong(
                                      song,
                                      queue: filteredSongs,
                                      index: index,
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'play',
                                    child: Row(
                                      children: [
                                        Icon(Icons.play_arrow_rounded, size: 20),
                                        SizedBox(width: 8),
                                        Text('Play Offline'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                                        SizedBox(width: 8),
                                        Text('Delete Download', style: TextStyle(color: Colors.redAccent)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            ref.read(playbackSessionProvider.notifier).playSong(
                              song,
                              queue: filteredSongs,
                              index: index,
                            );
                          },
                        ),
                      );
                    },
                    childCount: filteredSongs.length,
                  ),
                ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}
