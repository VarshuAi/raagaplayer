import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/settings_provider.dart';
import '../widgets/settings_tile.dart';
import '../../home/screens/home_screen.dart';
import '../../library/screens/folders_tab.dart';
import '../../../core/scanner/scanner_service.dart';
import '../../../core/services/cache_manager.dart';
import '../../../core/widgets/feedback/raaga_feedback.dart';

class LibrarySettingsScreen extends ConsumerWidget {
  const LibrarySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          SettingsTile(
            leadingIcon: Icons.restart_alt_rounded,
            title: 'Scan on Startup',
            subtitle: 'Automatically index files when app opens',
            trailing: Switch(
              value: settings.scanOnStartup,
              onChanged: (val) {
                notifier.updateSettings(settings.copyWith(scanOnStartup: val));
              },
            ),
            onTap: () {},
          ),
          const Divider(),
          SettingsTile(
            leadingIcon: Icons.youtube_searched_for_rounded,
            title: 'Force Rescan Catalog',
            subtitle: 'Manually trigger search scanner',
            onTap: () async {
              RaagaSnackBar.show(context: context, message: 'Media scanner triggered...');
              await ScannerService(database: db).triggerRescan();
              ref.invalidate(homeSongsProvider);
              RaagaSnackBar.show(context: context, message: 'Scan finished successfully.');
            },
          ),
          SettingsTile(
            leadingIcon: Icons.delete_sweep_rounded,
            title: 'Clear Cache & Temp Files',
            subtitle: 'Re-index artwork visual directories',
            onTap: () async {
              await CacheManager(database: db).clearArtworkCache();
              RaagaSnackBar.show(context: context, message: 'Artwork cache cleared.');
            },
          ),
          SettingsTile(
            leadingIcon: Icons.compress_rounded,
            title: 'Optimize Database',
            subtitle: 'Runs vacuum integrity script on SQLite',
            onTap: () async {
              await CacheManager(database: db).runDatabaseVacuum();
              RaagaSnackBar.show(context: context, message: 'Database optimized successfully.');
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'SCAN FOLDERS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          ref.watch(foldersProvider).when(
                loading: () => const Center(child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                )),
                error: (e, __) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Error loading folders: $e'),
                ),
                data: (folders) {
                  if (folders.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No folders detected. Trigger a scan first.'),
                    );
                  }
                  return Column(
                    children: folders.map((folderPath) {
                      final isSelected = settings.scanFolders.isEmpty ||
                          settings.scanFolders.contains(folderPath);
                      return CheckboxListTile(
                        title: Text(folderPath.split('/').last),
                        subtitle: Text(folderPath, style: const TextStyle(fontSize: 12)),
                        value: isSelected,
                        onChanged: (val) {
                          final currentList = List<String>.from(settings.scanFolders);
                          if (val == true) {
                            if (currentList.isEmpty) {
                              currentList.addAll(folders);
                            }
                            if (!currentList.contains(folderPath)) {
                              currentList.add(folderPath);
                            }
                          } else {
                            if (currentList.isEmpty) {
                              currentList.addAll(folders);
                            }
                            currentList.remove(folderPath);
                          }

                          if (currentList.length == folders.length || currentList.isEmpty) {
                            notifier.updateSettings(settings.copyWith(scanFolders: []));
                          } else {
                            notifier.updateSettings(settings.copyWith(scanFolders: currentList));
                          }
                        },
                      );
                    }).toList(),
                  );
                },
              ),
        ],
      ),
    );
  }
}
