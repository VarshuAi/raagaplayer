import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/player/provider/player_provider.dart';
import '../features/player/widgets/raaga_mini_player.dart';
import '../features/player/screens/now_playing_screen.dart';

import '../features/home/screens/home_screen.dart';

class NavigationShell extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShell({
    super.key,
    required this.navigationShell,
  });

  @override
  ConsumerState<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends ConsumerState<NavigationShell> {
  final List<int> _tabHistory = [0];

  void _onTabSelected(int index) {
    if (index == 0 && widget.navigationShell.currentIndex == 0) {
      refreshHomeFeed(ref);
    }

    if (widget.navigationShell.currentIndex != index) {
      _tabHistory.removeWhere((i) => i == index);
      _tabHistory.add(index);
      widget.navigationShell.goBranch(index);
    }
  }

  bool _handleBackPress() {
    // 1. If tab history has previous tabs, redirect to previous tab
    if (_tabHistory.length > 1) {
      setState(() {
        _tabHistory.removeLast(); // Remove current tab
        final previousTab = _tabHistory.last;
        widget.navigationShell.goBranch(previousTab);
      });
      return false; // Intercepted and switched tab
    }

    // 2. If not on Home tab, fallback to Home tab
    if (widget.navigationShell.currentIndex != 0) {
      setState(() {
        _tabHistory.clear();
        _tabHistory.add(0);
        widget.navigationShell.goBranch(0);
      });
      return false;
    }

    // 3. On Home tab with no sub-pages, allow app exit
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = ref.watch(currentSongProvider);
    final selectedIndex = widget.navigationShell.currentIndex;

    return WillPopScope(
      onWillPop: () async {
        final allowAppExit = _handleBackPress();
        return allowAppExit;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: currentSong != null ? 72.0 : 0.0,
                ),
                child: widget.navigationShell,
              ),
            ),
            if (currentSong != null)
              Positioned(
                left: 8,
                right: 8,
                bottom: 4.0,
                child: RaagaMiniPlayer(
                  song: currentSong,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NowPlayingScreen(),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: _onTabSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.library_music_rounded),
              label: 'Library',
            ),
            NavigationDestination(
              icon: Icon(Icons.download_for_offline_rounded),
              label: 'Downloads',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
