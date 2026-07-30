import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/storage_analyzer.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../../home/screens/home_screen.dart';

final storageReportProvider = FutureProvider<StorageReport>((ref) async {
  final db = ref.watch(databaseProvider);
  final analyzer = StorageAnalyzer(database: db);
  return analyzer.generateReport();
});

class StorageAnalyzerScreen extends ConsumerWidget {
  const StorageAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(storageReportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage Analyzer'),
        backgroundColor: Colors.transparent,
      ),
      body: reportAsync.when(
        loading: () => const Center(child: RaagaCircularIndicator()),
        error: (err, stack) => RaagaErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(storageReportProvider),
        ),
        data: (report) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Total Storage Used', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        '${report.totalSizeMb.toStringAsFixed(2)} MB',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.music_note_rounded),
                title: const Text('Total Songs Indexed'),
                trailing: Text('${report.totalSongs}'),
              ),
              ListTile(
                leading: const Icon(Icons.copy_all_rounded),
                title: const Text('Duplicate Tracks Found'),
                trailing: Text('${report.duplicateSongs.length}'),
              ),
              ListTile(
                leading: const Icon(Icons.file_open_rounded),
                title: const Text('Missing Files (Unlinked paths)'),
                trailing: Text('${report.missingFiles.length}'),
              ),
              if (report.missingFiles.isNotEmpty) ...[
                const SizedBox(height: 24),
                RaagaButton(
                  text: 'Clean Broken Path Links',
                  onTap: () async {
                    final db = ref.read(databaseProvider);
                    await StorageAnalyzer(database: db).cleanMissingTracks(report.missingFiles);
                    ref.invalidate(storageReportProvider);
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
