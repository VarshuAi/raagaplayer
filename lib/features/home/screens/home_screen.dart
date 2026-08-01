import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../../../core/widgets/cards/raaga_cards.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/song.dart';
import '../widgets/shelf_widget.dart';
import 'entity_detail_screen.dart';
import '../../player/provider/player_provider.dart';
import '../../../music/presentation/providers/music_providers.dart';

final ScrollController homeScrollController = ScrollController();

void refreshHomeFeed(WidgetRef ref) {
  if (homeScrollController.hasClients) {
    homeScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
  ref.invalidate(homeFeedProvider);
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Set<String> _selectedLanguages = {'hindi'};
  String _userName = 'Music Lover';

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    try {
      final docDir = await getApplicationDocumentsDirectory();

      // 1. Load User Name
      final nameFile = File(p.join(docDir.path, 'user_name.txt'));
      if (await nameFile.exists()) {
        final content = await nameFile.readAsString();
        if (content.trim().isNotEmpty) {
          _userName = content.trim();
        }
      }

      // 2. Load Selected Languages from onboarding
      final langFile = File(p.join(docDir.path, 'selected_languages.json'));
      if (await langFile.exists()) {
        final content = await langFile.readAsString();
        final List<dynamic> list = json.decode(content);
        if (list.isNotEmpty) {
          _selectedLanguages = list.map((e) => e.toString()).toSet();
        }
      }

      setState(() {});
    } catch (_) {}
  }

  final List<Map<String, String>> _languageChips = [
    {'id': 'hindi', 'label': 'Hindi'},
    {'id': 'english', 'label': 'English'},
    {'id': 'punjabi', 'label': 'Punjabi'},
    {'id': 'tamil', 'label': 'Tamil'},
    {'id': 'telugu', 'label': 'Telugu'},
    {'id': 'marathi', 'label': 'Marathi'},
    {'id': 'gujarati', 'label': 'Gujarati'},
    {'id': 'bengali', 'label': 'Bengali'},
    {'id': 'kannada', 'label': 'Kannada'},
    {'id': 'bhojpuri', 'label': 'Bhojpuri'},
    {'id': 'malayalam', 'label': 'Malayalam'},
    {'id': 'sanskrit', 'label': 'Sanskrit'},
    {'id': 'haryanvi', 'label': 'Haryanvi'},
    {'id': 'rajasthani', 'label': 'Rajasthani'},
    {'id': 'odia', 'label': 'Odia'},
    {'id': 'assamese', 'label': 'Assamese'},
  ];

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning, $_userName';
    if (hour < 17) return 'Good Afternoon, $_userName';
    if (hour < 21) return 'Good Evening, $_userName';
    return 'Good Night, $_userName';
  }

  void _toggleLanguage(String langId) async {
    setState(() {
      if (_selectedLanguages.contains(langId)) {
        if (_selectedLanguages.length > 1) {
          _selectedLanguages.remove(langId);
        }
      } else {
        _selectedLanguages.add(langId);
      }
    });

    try {
      final docDir = await getApplicationDocumentsDirectory();
      final langFile = File(p.join(docDir.path, 'selected_languages.json'));
      await langFile.writeAsString(json.encode(_selectedLanguages.toList()));
    } catch (_) {}

    ref.invalidate(homeFeedProvider(_selectedLanguages.join(',')));
  }

  Widget _buildHeroCarousel(List<Song> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    final featured = items.take(5).toList();

    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.90),
        itemCount: featured.length,
        itemBuilder: (context, index) {
          final song = featured[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  context.colorScheme.primary.withOpacity(0.90),
                  context.colorScheme.secondary.withOpacity(0.70),
                  const Color(0xFF0F1015),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.primary.withOpacity(0.35),
                  blurRadius: 16,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -15,
                  bottom: -15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      song.artworkUrl,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.75),
                          Colors.black.withOpacity(0.20),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 0.8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded, color: Colors.amber, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'SPOTLIGHT RELEASE',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 200,
                        child: Text(
                          _cleanText(song.title),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 200,
                        child: Text(
                          _cleanText(song.artist),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 14),
                      InkWell(
                        onTap: () {
                          ref.read(playbackSessionProvider.notifier).playSong(song, queue: items, index: index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.play_arrow_rounded, color: context.colorScheme.primary, size: 20),
                              const SizedBox(width: 6),
                              Text(
                                'LISTEN NOW',
                                style: TextStyle(color: context.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final languagesKey = _selectedLanguages.join(',');
    final homeFeedAsync = ref.watch(homeFeedProvider(languagesKey));

    final initialChar = _userName.isNotEmpty ? _userName[0].toUpperCase() : 'M';

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: Container(
            width: 40,
            height: 40,
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
                  color: context.colorScheme.primary.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                initialChar,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Discover',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(homeFeedProvider(languagesKey));
          await ref.read(homeFeedProvider(languagesKey).future);
        },
        child: SingleChildScrollView(
          controller: homeScrollController,
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
              child: Text(
                _getGreeting(),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Horizontal Multi-Language Selector Chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: _languageChips.length,
                itemBuilder: (context, index) {
                  final lang = _languageChips[index];
                  final isSelected = _selectedLanguages.contains(lang['id']);

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(lang['label']!),
                      selected: isSelected,
                      selectedColor: context.colorScheme.primary,
                      backgroundColor: context.colorScheme.surfaceContainerHigh,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : context.colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (_) => _toggleLanguage(lang['id']!),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            homeFeedAsync.when(
              loading: () => const SizedBox(
                height: 220,
                child: Center(child: RaagaCircularIndicator()),
              ),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: RaagaErrorState(
                  message: err.toString(),
                  onRetry: () => ref.invalidate(homeFeedProvider(languagesKey)),
                ),
              ),
              data: (shelves) {
                if (shelves.isEmpty) return const SizedBox.shrink();

                // Group Shelves: Section 1 (Trending Songs 1st), Section 2 (Albums 2nd), Section 3 (Playlists & Charts 3rd)
                final songShelves = shelves.where((s) => s.title.contains('Trending') || s.title.contains('Hits')).toList();
                final albumShelves = shelves.where((s) => s.title.contains('Releases') || s.title.contains('Albums')).toList();
                final otherShelves = shelves.where((s) => !songShelves.contains(s) && !albumShelves.contains(s)).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SPOTLIGHT HERO CAROUSEL (Spotify/YT Music Style)
                    if (songShelves.isNotEmpty && songShelves.first.items.isNotEmpty) ...[
                      _buildHeroCarousel(songShelves.first.items),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    // 1. TOP SECTION: Trending Songs List (Matching Reference Image)
                    if (songShelves.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                        child: Text(
                          'Trending Music',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      ...songShelves.map((shelf) => _buildSongsSection(context, shelf.items)).toList(),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    // 2. SECOND SECTION: Albums & EP Releases (Square Cards)
                    if (albumShelves.isNotEmpty) ...[
                      ...albumShelves.map((shelf) => _buildDynamicShelf('Popular Albums & EPs', shelf.subtitle, shelf.items)).toList(),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    // 3. THIRD SECTION: Playlists & Charts
                    if (otherShelves.isNotEmpty) ...[
                      ...otherShelves.map((shelf) => _buildDynamicShelf(shelf.title, shelf.subtitle, shelf.items)).toList(),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            _buildQuickAccessSection(context),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildSongsSection(BuildContext context, List<Song> items) {
    final displaySongs = items.take(6).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      itemCount: displaySongs.length,
      itemBuilder: (context, index) {
        final song = displaySongs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                song.artworkUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 48,
                  height: 48,
                  color: context.colorScheme.surfaceContainerHigh,
                  child: const Icon(Icons.music_note_rounded),
                ),
              ),
            ),
            title: Text(
              _cleanText(song.title),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: Text(
              _cleanText(song.artist),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.colorScheme.onSurface.withOpacity(0.55),
                fontSize: 12,
              ),
            ),
            trailing: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: context.colorScheme.onSurface.withOpacity(0.60),
              ),
              onSelected: (val) {
                if (val == 'play') {
                  ref.read(playbackSessionProvider.notifier).playSong(
                    song,
                    queue: items,
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
                      Text('Play Track'),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              ref.read(playbackSessionProvider.notifier).playSong(
                song,
                queue: items,
                index: index,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildQuickAccessSection(BuildContext context) {
    final items = [
      {'icon': Icons.favorite_rounded, 'title': 'Favorites', 'route': '/library', 'color': const Color(0xFFEF4444)},
      {'icon': Icons.history_rounded, 'title': 'Recently Added', 'route': '/library', 'color': const Color(0xFF3B82F6)},
      {'icon': Icons.download_rounded, 'title': 'Offline Downloads', 'route': '/downloads', 'color': const Color(0xFF10B981)},
      {'icon': Icons.queue_music_rounded, 'title': 'Playlists', 'route': '/library', 'color': const Color(0xFFF59E0B)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 64,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              final iconColor = item['color'] as Color;

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => context.go(item['route'] as String),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: context.colorScheme.onSurface.withOpacity(0.06),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: iconColor.withOpacity(0.15),
                        ),
                        child: Icon(item['icon'] as IconData, color: iconColor, size: 22),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
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

        final isContainer = song.sourceUrl.isEmpty ||
            song.sourceUrl == '#' ||
            (!song.sourceUrl.contains('.mp4') &&
             !song.sourceUrl.contains('.mp3') &&
             !song.sourceUrl.contains('media_url') &&
             !song.sourceUrl.contains('/api/stream') &&
             (song.sourceUrl.contains('/album/') ||
              song.sourceUrl.contains('/featured/') ||
              song.sourceUrl.contains('/playlist/') ||
              title.toLowerCase().contains('playlists') ||
              title.toLowerCase().contains('charts') ||
              title.toLowerCase().contains('albums') ||
              title.toLowerCase().contains('releases') ||
              title.toLowerCase().contains('top artist') ||
              title.toLowerCase().contains('mix') ||
              title.toLowerCase().contains('featured')));

        return Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: RaagaCard(
            width: 140.0,
            surfaceLevel: 2,
            padding: const EdgeInsets.all(AppSpacing.sm),
            onTap: () {
              final lowerTitle = title.toLowerCase();
              final isRadio = lowerTitle.contains('radio') ||
                  song.title.toLowerCase().contains('radio') ||
                  song.artist.toLowerCase().contains('radio');

              final isPlaylist = song.sourceUrl.contains('/featured/') ||
                  song.sourceUrl.contains('/playlist/') ||
                  lowerTitle.contains('playlist') ||
                  lowerTitle.contains('chart');

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EntityDetailScreen(
                    entityId: song.id,
                    title: song.title.isNotEmpty ? song.title : song.artist,
                    subtitle: song.artist.isNotEmpty ? song.artist : 'Album',
                    artworkUrl: song.artworkUrl,
                    type: isRadio ? 'radio' : (isPlaylist ? 'playlist' : 'album'),
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RaagaArtwork(
                  imageUrl: song.artworkUrl,
                  size: 120.0,
                  radius: 12.0,
                  heroTag: 'home_${title.replaceAll(' ', '_')}_${song.id}_$index',
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _cleanText(song.title),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  _cleanText(song.artist),
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

  String _cleanText(String text) {
    return text
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&#039;', "'")
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
  }
}
