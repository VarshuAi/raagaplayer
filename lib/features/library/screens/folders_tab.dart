import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../home/screens/home_screen.dart';

final foldersProvider = FutureProvider<List<String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final list = await db.select(db.folders).get();
  return list.map((f) => f.path).toList();
});

class FoldersTab extends ConsumerWidget {
  const FoldersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersAsync = ref.watch(foldersProvider);

    return Scaffold(
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
              description: 'Index directories will appear here after media scan.',
              icon: Icons.folder_rounded,
            );
          }

          return ListView.builder(
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return ListTile(
                leading: const Icon(Icons.folder_rounded),
                title: Text(folder),
                onTap: () {
                  // Navigate to Folder track view
                },
              );
            },
          );
        },
      ),
    );
  }
}
