import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/widgets/inputs/raaga_inputs.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../../../core/search/search_index.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/database/app_database.dart' hide Song, Playlist;
import '../../../domain/entities/song.dart';
import '../../player/provider/player_provider.dart';
import '../../../music/presentation/providers/music_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  static const _voiceChannel = MethodChannel('com.raaga.music/voice');

  Future<void> _startVoiceSearch() async {
    if (!Platform.isAndroid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voice search is only supported on Android.')),
      );
      return;
    }
    try {
      final String? result = await _voiceChannel.invokeMethod('startVoiceRecognizer');
      if (result != null && result.isNotEmpty && mounted) {
        setState(() {
          _searchController.text = result;
        });
        _saveSearchTerm(result);
        _performSearch(result);
      }
    } on PlatformException catch (e) {
      print('[VoiceSearch] Failed to trigger speech recognizer: ${e.message}');
    }
  }
  List<Song> _searchResults = [];
  bool _isLoading = false;
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(trendingSongsProvider);
    });
  }

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _performSearch(query);
    });
  }

  Future<void> _loadRecentSearches() async {
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(docDir.path, 'recent_searches.json'));
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> list = json.decode(content);
        setState(() {
          _recentSearches = list.map((e) => e.toString()).toList();
        });
      }
    } catch (_) {}
  }

  Future<void> _saveSearchTerm(String term) async {
    final clean = term.trim();
    if (clean.isEmpty) return;

    final updated = List<String>.from(_recentSearches);
    updated.removeWhere((item) => item.toLowerCase() == clean.toLowerCase());
    updated.insert(0, clean);
    if (updated.length > 10) {
      updated.removeLast();
    }

    setState(() {
      _recentSearches = updated;
    });

    try {
      final docDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(docDir.path, 'recent_searches.json'));
      await file.writeAsString(json.encode(updated));
    } catch (_) {}
  }

  Future<void> _clearRecentSearches() async {
    setState(() {
      _recentSearches.clear();
    });
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(docDir.path, 'recent_searches.json'));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      final searchUseCase = ref.read(searchMusicUseCaseProvider);
      final result = await searchUseCase.execute(query);

      List<Song> finalResults = [];

      if (result.isSuccess) {
        finalResults = result.success.songs;
      }

      if (finalResults.isEmpty) {
        final db = ref.read(databaseProvider);
        final searchIndex = SearchIndex(database: db);
        final localResults = await searchIndex.performSearch(query);
        finalResults = localResults.songs
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
      }

      setState(() {
        _searchResults = finalResults;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  String _cleanText(String text) {
    return text
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&#039;', "'")
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
  }

  @override
  Widget build(BuildContext context) {
    final trendingAsync = ref.watch(trendingSongsProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Search',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onSubmitted: (term) {
                _saveSearchTerm(term);
                _performSearch(term);
              },
              style: TextStyle(color: context.colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Search songs, artists, albums...',
                hintStyle: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.40)),
                prefixIcon: Icon(Icons.search_rounded, color: context.colorScheme.onSurface.withOpacity(0.60)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.mic_none_rounded, color: context.colorScheme.onSurface.withOpacity(0.60)),
                        onPressed: _startVoiceSearch,
                      ),
                filled: true,
                fillColor: context.colorScheme.surfaceContainerHigh,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: RaagaCircularIndicator())
                : _searchController.text.isNotEmpty
                    ? _searchResults.isEmpty
                        ? const RaagaEmptyState(
                            title: 'No Matches Found',
                            description: 'Try searching with different keywords.',
                            icon: Icons.search_off_rounded,
                          )
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                            itemBuilder: (context, index) {
                              final song = _searchResults[index];
                              final cleanTitle = _cleanText(song.title);
                              final cleanArtist = _cleanText(song.artist);
                              final cleanAlbum = _cleanText(song.album);

                              return ListTile(
                                leading: RaagaArtwork(
                                  imageUrl: song.artworkUrl,
                                  size: 48,
                                  radius: 8,
                                ),
                                title: _highlightMatches(cleanTitle, _searchController.text),
                                subtitle: Text(
                                  cleanAlbum.isNotEmpty ? '$cleanArtist • $cleanAlbum' : cleanArtist,
                                ),
                                onTap: () {
                                  _saveSearchTerm(_searchController.text.isNotEmpty ? _searchController.text : cleanTitle);
                                  ref.read(playbackSessionProvider.notifier).playSong(
                                    song,
                                    queue: [song],
                                    index: 0,
                                  );
                                },
                              );
                            },
                          )
                    : RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(trendingSongsProvider);
                          await ref.read(trendingSongsProvider.future);
                        },
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_recentSearches.isNotEmpty) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recent Searches',
                                      style: context.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: _clearRecentSearches,
                                      child: Text(
                                        'Clear All',
                                        style: TextStyle(
                                          color: context.colorScheme.primary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _recentSearches.map((term) {
                                    return ActionChip(
                                      label: Text(_cleanText(term)),
                                      labelStyle: TextStyle(
                                        color: context.colorScheme.onSurface,
                                        fontSize: 13,
                                      ),
                                      backgroundColor: context.colorScheme.surfaceContainerHigh,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      onPressed: () {
                                        _searchController.text = term;
                                        _performSearch(term);
                                      },
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: AppSpacing.xl),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Trending Now',
                                    style: context.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.refresh_rounded, size: 20),
                                    tooltip: 'Refresh Trending',
                                    onPressed: () {
                                      ref.invalidate(trendingSongsProvider);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              trendingAsync.when(
                                loading: () => const Center(child: RaagaCircularIndicator()),
                                error: (_, __) => const Text('No trending songs available'),
                                data: (songs) {
                                  return Column(
                                    children: songs.take(15).map((song) {
                                      final cleanTitle = _cleanText(song.title);
                                      final cleanArtist = _cleanText(song.artist);

                                      return ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: RaagaArtwork(
                                          imageUrl: song.artworkUrl,
                                          size: 48,
                                          radius: 8,
                                        ),
                                        title: Text(
                                          cleanTitle,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(cleanArtist),
                                        onTap: () {
                                          _saveSearchTerm(cleanTitle);
                                          ref.read(playbackSessionProvider.notifier).playSong(
                                            song,
                                            queue: [song],
                                            index: 0,
                                          );
                                        },
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _highlightMatches(String text, String query) {
    if (query.isEmpty) return Text(text);
    final cleanText = text.toLowerCase();
    final cleanQuery = query.toLowerCase();
    final index = cleanText.indexOf(cleanQuery);

    if (index == -1) return Text(text);

    return RichText(
      text: TextSpan(
        style: TextStyle(color: context.colorScheme.onSurface, fontSize: 16),
        children: [
          TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: TextStyle(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
              backgroundColor: context.colorScheme.primary.withOpacity(0.12),
            ),
          ),
          TextSpan(text: text.substring(index + query.length)),
        ],
      ),
    );
  }
}
