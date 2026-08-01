import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Songs extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get artist => text()();
  TextColumn get album => text()();
  TextColumn get duration => text()();
  IntColumn get durationMs => integer().nullable()();
  TextColumn get path => text()();
  IntColumn get bitrate => integer().nullable()();
  IntColumn get trackNumber => integer().nullable()();
  IntColumn get year => integer().nullable()();
  TextColumn get genre => text().nullable()();
  TextColumn get folder => text()();
  TextColumn get artworkUrl => text().nullable()();
  BoolColumn get isLocal => boolean().withDefault(const Constant(true))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Albums extends Table {
  TextColumn get name => text()();
  TextColumn get artist => text()();
  TextColumn get artworkUrl => text().nullable()();
  IntColumn get songCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {name, artist};
}

class Artists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get artworkUrl => text().nullable()();
  IntColumn get monthlyListeners => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Genres extends Table {
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {name};
}

class Folders extends Table {
  TextColumn get path => text()();

  @override
  Set<Column> get primaryKey => {path};
}

class Playlists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get artworkUrl => text().nullable()();
  TextColumn get creator => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class PlaylistSongs extends Table {
  TextColumn get playlistId => text()();
  TextColumn get songId => text()();
  IntColumn get sequence => integer()();

  @override
  Set<Column> get primaryKey => {playlistId, songId};
}

class History extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get songId => text()();
  DateTimeColumn get playedAt => dateTime()();
}

class RecentlyPlayed extends Table {
  TextColumn get songId => text()();
  DateTimeColumn get playedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {songId};
}

class QueueItems extends Table {
  TextColumn get songId => text()();
  IntColumn get sequence => integer()();

  @override
  Set<Column> get primaryKey => {songId};
}

class LyricsTable extends Table {
  TextColumn get songId => text()();
  TextColumn get lyricsText => text()();

  @override
  Set<Column> get primaryKey => {songId};
}

class SleepTimerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get durationMinutes => integer()();
  DateTimeColumn get triggerTime => dateTime()();
}

class SettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

class PlaybackStateTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get currentSongId => text().nullable()();
  IntColumn get currentPositionMs => integer().withDefault(const Constant(0))();
  IntColumn get queueIndex => integer().withDefault(const Constant(0))();
  BoolColumn get isShuffle => boolean().withDefault(const Constant(false))();
  IntColumn get repeatMode => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class ArtworkCacheTable extends Table {
  TextColumn get id => text()();
  TextColumn get path => text()();
  TextColumn get dominantColor => text().nullable()();
  TextColumn get vibrantColor => text().nullable()();
  TextColumn get darkColor => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Downloads extends Table {
  TextColumn get id => text()();
  TextColumn get songId => text()();
  TextColumn get providerId => text()();
  TextColumn get path => text().nullable()();
  IntColumn get status => integer()();
  RealColumn get progress => real()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CloudSync extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get providerId => text()();
  IntColumn get operation => integer()();
  IntColumn get version => integer()();
  TextColumn get syncState => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class StreamingCache extends Table {
  TextColumn get key => text()();
  TextColumn get providerId => text()();
  TextColumn get path => text()();
  IntColumn get size => integer()();
  DateTimeColumn get lastAccessedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

class LyricsCache extends Table {
  TextColumn get songId => text()();
  TextColumn get providerId => text()();
  TextColumn get content => text()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {songId};
}

class Authentication extends Table {
  TextColumn get providerId => text()();
  TextColumn get userId => text()();
  BoolColumn get isLoggedIn => boolean().withDefault(const Constant(false))();
  TextColumn get displayName => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {providerId, userId};
}

class ProviderSettings extends Table {
  TextColumn get id => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get healthStatus => text().withDefault(const Constant('healthy'))();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncTableName => text()();
  TextColumn get recordId => text()();
  TextColumn get operation => text()();
  TextColumn get payload => text()();
  IntColumn get retries => integer().withDefault(const Constant(0))();
}

class MediaQuality extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

class PlaybackStatistics extends Table {
  TextColumn get songId => text()();
  IntColumn get playCount => integer().withDefault(const Constant(0))();
  IntColumn get skipCount => integer().withDefault(const Constant(0))();
  RealColumn get completionRate => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastPlayedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {songId};
}

class ListeningSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get songId => text()();
  DateTimeColumn get playedAt => dateTime()();
  IntColumn get durationSeconds => integer()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  TextColumn get timeOfDay => text()();
  IntColumn get dayOfWeek => integer()();
}

class RecentSearches extends Table {
  TextColumn get query => text()();
  DateTimeColumn get searchedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {query};
}

@DriftDatabase(tables: [
  Songs,
  Albums,
  Artists,
  Genres,
  Folders,
  Playlists,
  PlaylistSongs,
  History,
  RecentlyPlayed,
  QueueItems,
  LyricsTable,
  SleepTimerTable,
  SettingsTable,
  PlaybackStateTable,
  ArtworkCacheTable,
  Downloads,
  CloudSync,
  StreamingCache,
  LyricsCache,
  Authentication,
  ProviderSettings,
  SyncQueue,
  MediaQuality,
  PlaybackStatistics,
  ListeningSessions,
  RecentSearches
])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  factory AppDatabase.instance() {
    _instance ??= AppDatabase._(_openConnection());
    return _instance!;
  }

  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());
  AppDatabase._(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await initFts();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(playbackStatistics);
        await m.createTable(listeningSessions);
        await m.createTable(recentSearches);
      }
    },
  );

  Future<void> initFts() async {
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS song_search_index USING fts5(
        song_id,
        title,
        artist,
        album
      );
    ''');
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbDir.path, 'raaga_music.db'));
      return NativeDatabase(
        file,
        setup: (rawDb) {
          rawDb.execute('PRAGMA journal_mode=WAL;');
          rawDb.execute('PRAGMA busy_timeout=5000;');
        },
      );
    });
  }
}

/// Global Riverpod provider for the Drift database.
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase.instance();
});
