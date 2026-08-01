import 'dart:ffi';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:raaga_music_player/core/database/app_database.dart' as db;
import 'package:raaga_music_player/music/domain/entities/song.dart';
import 'package:raaga_music_player/music/application/recommendation_weights.dart';
import 'package:raaga_music_player/music/application/recommendation_engine.dart';
import 'package:raaga_music_player/music/application/smart_playlist_engine.dart';
import 'package:raaga_music_player/music/application/radio_engine.dart';
import 'package:raaga_music_player/core/scanner/library_intelligence.dart';
import 'package:raaga_music_player/core/audio/queue_manager.dart';
import 'package:drift/drift.dart';
import 'package:sqlite3/open.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    open.overrideFor(OperatingSystem.windows, () {
      return DynamicLibrary.open('winsqlite3.dll');
    });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
        return null;
      },
    );
  });

  group('Phase 9 On-Device Music Intelligence Tests', () {
    late db.AppDatabase database;

    setUp(() async {
      database = db.AppDatabase();
      // Ensure absolute cleanliness before starting any test
      try {
        await database.delete(database.songs).go();
        await database.delete(database.playbackStatistics).go();
        await database.delete(database.listeningSessions).go();
        await database.delete(database.recentSearches).go();
      } catch (_) {}
    });

    tearDown(() async {
      try {
        await database.delete(database.songs).go();
        await database.delete(database.playbackStatistics).go();
        await database.delete(database.listeningSessions).go();
        await database.delete(database.recentSearches).go();
      } catch (_) {}
      await database.close();
    });

    test('RecommendationEngine correctly applies weights & recency decay', () async {
      final recEngine = RecommendationEngine(
        database,
        weights: const RecommendationWeights(
          playCountWeight: 2.0,
          skipPenalty: 1.0,
          favoriteBonus: 5.0,
          completionBonus: 3.0,
          recencyBonus: 4.0,
          recencyHalfLifeDays: 10.0,
        ),
      );

      await database.into(database.songs).insert(
        db.SongsCompanion.insert(
          id: 'song1',
          title: 'Song One',
          artist: 'Artist A',
          album: 'Album X',
          path: '/path/1',
          duration: '3:00',
          folder: 'root',
          isLocal: const Value(true),
          isFavorite: const Value(false),
        ),
      );

      await database.into(database.songs).insert(
        db.SongsCompanion.insert(
          id: 'song2',
          title: 'Song Two',
          artist: 'Artist B',
          album: 'Album Y',
          path: '/path/2',
          duration: '3:00',
          folder: 'root',
          isLocal: const Value(true),
          isFavorite: const Value(true),
        ),
      );

      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      await database.into(database.playbackStatistics).insert(
        db.PlaybackStatisticsCompanion.insert(
          songId: 'song1',
          playCount: const Value(5),
          skipCount: const Value(1),
          completionRate: const Value(0.8),
          lastPlayedAt: Value(yesterday),
        ),
      );

      final recommended = await recEngine.getRecommendations(limit: 2);
      expect(recommended.length, 2);
      expect(recommended[0].id, 'song1');
      expect(recommended[1].id, 'song2');
    });

    test('SmartPlaylistEngine compiles automatic playlists', () async {
      final engine = SmartPlaylistEngine(database);

      await database.into(database.songs).insert(
        db.SongsCompanion.insert(
          id: 'track1',
          title: 'Morning Star',
          artist: 'Artist C',
          album: 'Album Z',
          path: '/path/3',
          duration: '3:00',
          folder: 'root',
          genre: const Value('workout'),
          isLocal: const Value(true),
          isFavorite: const Value(true),
        ),
      );

      final favoritesList = await engine.getPlaylistTracks(SmartPlaylistType.favorites);
      expect(favoritesList.length, 1);
      expect(favoritesList[0].id, 'track1');

      final workoutList = await engine.getPlaylistTracks(SmartPlaylistType.workout);
      expect(workoutList.length, 1);
      expect(workoutList[0].title, 'Morning Star');
    });

    test('RadioEngine cascading seed generation', () async {
      final engine = RadioEngine(database);

      await database.into(database.songs).insert(
        db.SongsCompanion.insert(
          id: 'seed',
          title: 'Seed Track',
          artist: 'Artist Star',
          album: 'Album Galaxy',
          path: '/seed',
          duration: '3:00',
          folder: 'root',
          genre: const Value('Synthwave'),
          isLocal: const Value(true),
          isFavorite: const Value(false),
        ),
      );

      await database.into(database.songs).insert(
        db.SongsCompanion.insert(
          id: 'similar_artist',
          title: 'Matching Artist Track',
          artist: 'Artist Star',
          album: 'Other Album',
          path: '/path/similar',
          duration: '3:00',
          folder: 'root',
          genre: const Value('Pop'),
          isLocal: const Value(true),
          isFavorite: const Value(false),
        ),
      );

      final radioQueue = await engine.generateRadioQueue(
        Song(
          id: 'seed',
          title: 'Seed Track',
          artist: 'Artist Star',
          album: 'Album Galaxy',
          artworkUrl: '',
          sourceUrl: '/seed',
          duration: Duration.zero,
          isLocal: true,
          isFavorite: false,
        ),
        limit: 5,
      );

      expect(radioQueue.isNotEmpty, true);
      expect(radioQueue[0].id, 'similar_artist');
    });

    test('LibraryIntelligence flags duplicate/metadata issues', () async {
      final libIntel = LibraryIntelligence(database);

      await database.into(database.songs).insert(
        db.SongsCompanion.insert(
          id: 'dup1',
          title: 'Duplicate Title',
          artist: 'Unknown',
          album: 'Unknown',
          path: '/path/dup1',
          duration: '3:00',
          folder: 'root',
          durationMs: const Value(180000),
          isLocal: const Value(true),
          isFavorite: const Value(false),
        ),
      );

      await database.into(database.songs).insert(
        db.SongsCompanion.insert(
          id: 'dup2',
          title: 'Duplicate Title',
          artist: 'Unknown',
          album: 'Unknown',
          path: '/path/dup2',
          duration: '3:00',
          folder: 'root',
          durationMs: const Value(180000),
          isLocal: const Value(true),
          isFavorite: const Value(false),
        ),
      );

      final issues = await libIntel.scanLibrary();
      expect(issues.isNotEmpty, true);

      final duplicateIssue = issues.firstWhere((i) => i.category == 'duplicates');
      expect(duplicateIssue.affectedSongIds.contains('dup2'), true);

      final metadataIssue = issues.firstWhere((i) => i.category == 'metadata' && i.title.contains('Artist'));
      expect(metadataIssue.affectedSongIds.contains('dup1'), true);
    });

    test('QueueManager smart shuffle separates adjacent artists', () async {
      final qm = QueueManager();
      qm.clear();

      final songA1 = Song(id: 'a1', title: 'Song 1', artist: 'Artist A', album: '', artworkUrl: '', sourceUrl: '', duration: Duration.zero, isLocal: true, isFavorite: false);
      final songA2 = Song(id: 'a2', title: 'Song 2', artist: 'Artist A', album: '', artworkUrl: '', sourceUrl: '', duration: Duration.zero, isLocal: true, isFavorite: false);
      final songB1 = Song(id: 'b1', title: 'Song 3', artist: 'Artist B', album: '', artworkUrl: '', sourceUrl: '', duration: Duration.zero, isLocal: true, isFavorite: false);

      qm.addAll([songA1, songA2, songB1]);

      qm.smartShuffle([]);

      final shuffled = qm.currentQueue.items;
      expect(shuffled.length, 3);
      
      for (int i = 0; i < shuffled.length - 1; i++) {
        if (shuffled[i].artist == 'Artist A' && shuffled[i + 1].artist == 'Artist A') {
          fail('Adjacent duplicate artist detected: ${shuffled[i].artist} & ${shuffled[i+1].artist}');
        }
      }
    });
  });
}
