import 'package:flutter_test/flutter_test.dart';
import 'package:raaga_music_player/features/auth/data/services/secure_storage_service.dart';
import 'package:raaga_music_player/core/streaming/media_quality_manager.dart';
import 'package:raaga_music_player/core/streaming/streaming_engine.dart';
import 'package:raaga_music_player/core/streaming/streaming_cache_manager.dart';
import 'package:raaga_music_player/core/database/app_database.dart' hide Song, Playlist;
import 'package:raaga_music_player/core/network/network_monitor.dart';
import 'package:raaga_music_player/music/domain/entities/song.dart';
import 'package:http/http.dart' as http;

class MockNetworkMonitor implements NetworkMonitor {
  final bool _connected;
  MockNetworkMonitor(this._connected);

  @override
  Future<bool> get isConnected async => _connected;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phase 8 Module Tests', () {
    late AppDatabase database;

    setUp(() {
      database = AppDatabase();
    });

    tearDown(() async {
      await database.close();
    });

    test('SecureStorageService reads and writes keys securely', () async {
      final storage = SecureStorageService();
      await storage.write('test_key', 'test_val');
      final val = await storage.read('test_key');
      expect(val, 'test_val');

      await storage.delete('test_key');
      final valAfterDelete = await storage.read('test_key');
      expect(valAfterDelete, null);
    });

    test('MediaQualityManager returns correct profiles', () async {
      final qm = MediaQualityManager(database: database);
      final profileWifi = await qm.getActiveQualityProfile(isWifi: true, isRoaming: false);
      expect(profileWifi, MediaQualityProfile.high);

      final profileRoaming = await qm.getActiveQualityProfile(isWifi: false, isRoaming: true);
      expect(profileRoaming, MediaQualityProfile.low);
    });

    test('StreamingEngine computes correct adaptive URLs', () async {
      final qm = MediaQualityManager(database: database);
      final nm = MockNetworkMonitor(true);
      final se = StreamingEngine(
        client: http.Client(),
        qualityManager: qm,
        networkMonitor: nm,
      );

      const song = Song(
        id: '123',
        title: 'Song',
        artist: 'Artist',
        album: 'Album',
        artworkUrl: '',
        sourceUrl: 'https://example.com/stream?id=123',
        duration: Duration(seconds: 100),
      );

      final url = await se.getStreamingUrl(song);
      expect(url.contains('quality=high') || url.contains('quality=medium'), true);
    });

    test('StreamingCacheManager caches segments and deletes old files', () async {
      final cacheManager = StreamingCacheManager(database: database, maxCacheSizeBytes: 10);
      await cacheManager.cacheSegment('key1', 'local', [1, 2, 3]);
      await cacheManager.cacheSegment('key2', 'local', [4, 5, 6, 7]);
      
      await cacheManager.cacheSegment('key3', 'local', [8, 9, 10, 11, 12]);
      
      final f = await cacheManager.getCachedSegment('key1', 'local');
      expect(await f.exists(), false);
    });
  });
}
