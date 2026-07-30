import 'package:drift/drift.dart';
import '../database/app_database.dart';

class MetadataEditor {
  final AppDatabase database;

  MetadataEditor({required this.database});

  Future<void> updateSongMetadata({
    required String songId,
    required String title,
    required String artist,
    required String album,
    String? genre,
    int? trackNumber,
    int? year,
  }) async {
    // 1. Update Drift database records for matching song Id
    await (database.update(database.songs)..where((t) => t.id.equals(songId))).write(
      SongsCompanion(
        title: Value(title),
        artist: Value(artist),
        album: Value(album),
        genre: Value(genre),
        trackNumber: Value(trackNumber),
        year: Value(year),
      ),
    );

    // 2. Refresh matching album catalog counts
    await database.into(database.albums).insertOnConflictUpdate(
          AlbumsCompanion(
            name: Value(album),
            artist: Value(artist),
            songCount: const Value(1),
          ),
        );
  }
}
