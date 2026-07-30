import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/icons/raaga_icons.dart';
import '../core/extensions/context_extensions.dart';
import '../features/player/provider/player_provider.dart';
import '../features/player/widgets/raaga_mini_player.dart';
import '../features/player/screens/now_playing_screen.dart';

class NavigationShell extends ConsumerWidget {
  final Widget child;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const NavigationShell({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: currentSong != null ? 80.0 : 0.0,
              ),
              child: child,
            ),
          ),
          if (currentSong != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 8.0,
              child: RaagaMiniPlayer(
                song: currentSong,
                onTap: () {
                  // Navigate to Now Playing Screen using bottom sheet or full push transition
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
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(RaagaIcons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(RaagaIcons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(RaagaIcons.library),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
