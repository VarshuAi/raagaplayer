import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/inputs/raaga_inputs.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/search/search_index.dart';
import '../../home/screens/home_screen.dart';
import '../../../domain/entities/song.dart';
import '../../player/provider/playback_provider.dart';
import '../../player/provider/player_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Song> _searchResults = [];
  bool _isLoading = false;
  String _activeCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
      final db = ref.read(databaseProvider);
      final searchIndex = SearchIndex(database: db);
      final results = await searchIndex.performSearch(query);

      setState(() {
        _searchResults = results.songs;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: RaagaSearchBar(
          controller: _searchController,
          hintText: 'Search songs, albums, artists...',
          onChanged: _performSearch,
          onClear: () => _performSearch(''),
        ),
      ),
      body: _isLoading
          ? const Center(child: RaagaCircularIndicator())
          : _searchController.text.isEmpty
              ? const RaagaEmptyState(
                  title: 'Search Local Music',
                  description: 'Type matching titles, artists, or folders.',
                  icon: Icons.search_rounded,
                )
              : _searchResults.isEmpty
                  ? const RaagaEmptyState(
                      title: 'No Matches Found',
                      description: 'Try searching with different spelling.',
                      icon: Icons.search_off_rounded,
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final song = _searchResults[index];
                        return ListTile(
                          leading: const Icon(Icons.music_note_rounded),
                          title: _highlightMatches(song.title, _searchController.text),
                          subtitle: Text('${song.artist} • ${song.album}'),
                          onTap: () {
                            ref.read(currentSongProvider.notifier).state = song;
                            ref.read(audioEngineProvider).setSource(song.sourceUrl).then((_) {
                              ref.read(audioEngineProvider).play();
                            });
                          },
                        );
                      },
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
