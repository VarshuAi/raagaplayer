import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import 'songs_tab.dart';
import 'favorites_tab.dart';
import 'downloads_tab.dart';
import 'albums_tab.dart';
import 'artists_tab.dart';
import 'playlists_tab.dart';
import 'genres_tab.dart';
import 'folders_tab.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'Favorites',
    'Downloads',
    'Songs',
    'Albums',
    'Artists',
    'Folders',
    'Genres',
    'Playlists',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Library',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => context.push('/settings'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: context.colorScheme.primary,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: context.colorScheme.onSurface.withOpacity(0.60),
            dividerColor: Colors.transparent,
            tabs: _tabs.map((name) => Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            )).toList(),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FavoritesTab(),
          DownloadsTab(),
          SongsTab(),
          AlbumsTab(),
          ArtistsTab(),
          FoldersTab(),
          GenresTab(),
          PlaylistsTab(),
        ],
      ),
    );
  }
}
