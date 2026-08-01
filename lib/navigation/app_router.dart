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
import '../debug/dev_console_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/download/presentation/screens/download_manager_screen.dart';
import '../features/settings/screens/provider_management_screen.dart';
import '../features/onboarding/screens/onboarding_language_screen.dart';
import '../features/onboarding/screens/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav');
final GlobalKey<NavigatorState> _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'searchNav');
final GlobalKey<NavigatorState> _libraryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'libraryNav');
final GlobalKey<NavigatorState> _downloadsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'downloadsNav');
final GlobalKey<NavigatorState> _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settingsNav');

GoRouter createRouter({required String initialLocation}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/splash',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnboardingLanguageScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationShell(
            navigationShell: navigationShell,
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
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _downloadsNavigatorKey,
            routes: [
              GoRoute(
                path: '/downloads',
                builder: (context, state) => const DownloadManagerScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
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
                  GoRoute(
                    path: 'developer',
                    builder: (context, state) => const DevConsoleScreen(),
                  ),
                  GoRoute(
                    path: 'providers',
                    builder: (context, state) => const ProviderManagementScreen(),
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
      GoRoute(
        path: AppRoutes.auth,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}

final goRouter = createRouter(initialLocation: '/splash');
