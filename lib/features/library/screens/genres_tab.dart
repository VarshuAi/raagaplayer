import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../home/screens/home_screen.dart';

final genresProvider = FutureProvider<List<String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final list = await db.select(db.genres).get();
  return list.map((g) => g.name).toList();
});

class GenresTab extends ConsumerWidget {
  const GenresTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresAsync = ref.watch(genresProvider);

    return Scaffold(
      body: genresAsync.when(
        loading: () => const Center(child: RaagaCircularIndicator()),
        error: (err, stack) => RaagaErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(genresProvider),
        ),
        data: (genres) {
          if (genres.isEmpty) {
            return const RaagaEmptyState(
              title: 'No Genres Scanned',
              description: 'Local cataloged songs do not specify genres.',
              icon: Icons.style_rounded,
            );
          }

          return ListView.builder(
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              return ListTile(
                leading: const Icon(Icons.style_rounded),
                title: Text(genre),
                onTap: () {
                  // Navigate to Genre track view
                },
              );
            },
          );
        },
      ),
    );
  }
}
