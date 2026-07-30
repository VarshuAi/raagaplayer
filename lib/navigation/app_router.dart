import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import 'navigation_shell.dart';
import '../features/home/screens/home_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/library/screens/library_screen.dart';
import '../features/dashboard/screens/design_system_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/settings/screens/appearance_settings_screen.dart';
import '../features/settings/screens/playback_settings_screen.dart';
import '../features/settings/screens/library_settings_screen.dart';
import '../features/settings/screens/backup_restore_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav');
final GlobalKey<NavigatorState> _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'searchNav');
final GlobalKey<NavigatorState> _libraryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'libraryNav');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationShell(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(index),
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _searchNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.search,
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _libraryNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.library,
              builder: (context, state) => const LibraryScreen(),
              routes: [
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                  routes: [
                    GoRoute(
                      path: 'appearance',
                      builder: (context, state) => const AppearanceSettingsScreen(),
                    ),
                    GoRoute(
                      path: 'playback',
                      builder: (context, state) => const PlaybackSettingsScreen(),
                    ),
                    GoRoute(
                      path: 'library',
                      builder: (context, state) => const LibrarySettingsScreen(),
                    ),
                    GoRoute(
                      path: 'backup',
                      builder: (context, state) => const BackupRestoreScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.designSystem,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const DesignSystemScreen(),
    ),
  ],
);
