import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
  ArtworkCacheTable
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbDir.path, 'raaga_music.db'));
      return NativeDatabase(file);
    });
  }
}
