import 'package:flutter/material.dart';
import '../core/icons/raaga_icons.dart';
import '../core/extensions/context_extensions.dart';
import '../core/widgets/buttons/raaga_buttons.dart';

class NavigationShell extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
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
          NavigationDestination(
            icon: Icon(RaagaIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
