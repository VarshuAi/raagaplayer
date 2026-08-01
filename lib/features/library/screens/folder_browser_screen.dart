import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/database/app_database.dart';

/// Provides the list of tracked folder paths from the database.
final foldersProvider = FutureProvider<List<String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await db.select(db.folders).get();
  return rows.map((f) => f.path).toList();
});

class FolderBrowserScreen extends ConsumerWidget {
  const FolderBrowserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersAsync = ref.watch(foldersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Folder Browser'),
        backgroundColor: Colors.transparent,
      ),
      body: foldersAsync.when(
        loading: () => const Center(child: RaagaCircularIndicator()),
        error: (err, stack) => RaagaErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(foldersProvider),
        ),
        data: (folders) {
          if (folders.isEmpty) {
            return const RaagaEmptyState(
              title: 'No Folders Tracked',
              description:
                  'Index directories will appear here after scanning music.',
              icon: Icons.folder_rounded,
            );
          }

          return ListView.builder(
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return ListTile(
                leading: const Icon(Icons.folder_open_rounded),
                title: Text(folder.split('/').last),
                subtitle: Text(folder),
                onTap: () {
                  // Navigate to tracks filtered by folder directory
                },
              );
            },
          );
        },
      ),
    );
  }
}
