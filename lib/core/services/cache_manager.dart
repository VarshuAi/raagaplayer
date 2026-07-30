import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../database/app_database.dart';

class CacheManager {
  final AppDatabase database;

  CacheManager({required this.database});

  Future<double> getArtworkCacheSizeMb() async {
    final tempDir = await getTemporaryDirectory();
    final cacheDir = Directory(p.join(tempDir.path, 'libCachedImageData'));
    if (!await cacheDir.exists()) return 0.0;

    int totalBytes = 0;
    await for (final file in cacheDir.list(recursive: true, followLinks: false)) {
      if (file is File) {
        totalBytes += await file.length();
      }
    }
    return totalBytes / (1024 * 1024);
  }

  Future<void> clearArtworkCache() async {
    final tempDir = await getTemporaryDirectory();
    final cacheDir = Directory(p.join(tempDir.path, 'libCachedImageData'));
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
    }
    // Drop artwork cache table references
    await database.delete(database.artworkCacheTable).go();
  }

  Future<void> runDatabaseVacuum() async {
    // SQLite VACUUM recovers unused space
    // Since Drift doesn't expose custom raw vacuum directly in simple APIs,
    // we run a custom sql execute statement.
    await database.customStatement('VACUUM;');
  }
}
