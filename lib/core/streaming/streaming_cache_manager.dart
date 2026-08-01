import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../database/app_database.dart';

class StreamingCacheManager {
  final AppDatabase database;
  final int maxCacheSizeBytes;

  StreamingCacheManager({
    required this.database,
    this.maxCacheSizeBytes = 512 * 1024 * 1024,
  });

  Future<Directory> get _cacheDir async {
    final docDir = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docDir.path, '.streaming_cache'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<File> getCachedSegment(String key, String providerId) async {
    final dir = await _cacheDir;
    final file = File(p.join(dir.path, '$key.cache'));
    
    if (await file.exists()) {
      await database.customStatement('''
        UPDATE streaming_cache
        SET last_accessed_at = ?
        WHERE key = ?;
      ''', [DateTime.now().toIso8601String(), key]);
    }
    
    return file;
  }

  Future<void> cacheSegment(String key, String providerId, List<int> bytes) async {
    final dir = await _cacheDir;
    final file = File(p.join(dir.path, '$key.cache'));
    await file.writeAsBytes(bytes);

    await database.customStatement('''
      INSERT OR REPLACE INTO streaming_cache (key, provider_id, path, size, last_accessed_at)
      VALUES (?, ?, ?, ?, ?);
    ''', [key, providerId, file.path, bytes.length, DateTime.now().toIso8601String()]);

    await _performLruCleanup();
  }

  Future<void> _performLruCleanup() async {
    final result = await database.customSelect('SELECT SUM(size) as total FROM streaming_cache;').getSingle();
    final totalSize = result.read<int?>('total') ?? 0;

    if (totalSize > maxCacheSizeBytes) {
      final rows = await database.customSelect('''
        SELECT key, path, size FROM streaming_cache
        ORDER BY last_accessed_at ASC;
      ''').get();

      int currentSize = totalSize;
      for (final r in rows) {
        if (currentSize <= maxCacheSizeBytes) break;
        final key = r.read<String>('key');
        final path = r.read<String>('path');
        final size = r.read<int>('size');

        final file = File(path);
        if (await file.exists()) {
          try {
            await file.delete();
          } catch (_) {}
        }

        await database.customStatement('DELETE FROM streaming_cache WHERE key = ?;', [key]);
        currentSize -= size;
      }
    }
  }
}
