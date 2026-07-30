import 'dart:io';
import '../database/app_database.dart';

class StorageReport {
  final int totalSongs;
  final int totalDurationMs;
  final double totalSizeMb;
  final List<String> duplicateSongs;
  final List<String> missingFiles;

  StorageReport({
    required this.totalSongs,
    required this.totalDurationMs,
    required this.totalSizeMb,
    required this.duplicateSongs,
    required this.missingFiles,
  });
}

class StorageAnalyzer {
  final AppDatabase database;

  StorageAnalyzer({required this.database});

  Future<StorageReport> generateReport() async {
    final songs = await database.select(database.songs).get();
    int totalDuration = 0;
    double totalSize = 0.0;
    
    final List<String> duplicates = [];
    final List<String> missing = [];
    final Set<String> titlesSeen = {};

    for (final song in songs) {
      totalDuration += song.durationMs ?? 0;
      
      // Calculate file size metrics
      final file = File(song.path);
      if (await file.exists()) {
        final length = await file.length();
        totalSize += length / (1024 * 1024); // Convert bytes to MB
      } else {
        missing.add(song.path);
      }

      // Check duplicates by exact name title
      final key = '${song.title.toLowerCase()} - ${song.artist.toLowerCase()}';
      if (titlesSeen.contains(key)) {
        duplicates.add(song.title);
      } else {
        titlesSeen.add(key);
      }
    }

    return StorageReport(
      totalSongs: songs.length,
      totalDurationMs: totalDuration,
      totalSizeMb: totalSize,
      duplicateSongs: duplicates,
      missingFiles: missing,
    );
  }

  Future<void> cleanMissingTracks(List<String> paths) async {
    for (final path in paths) {
      await (database.delete(database.songs)..where((t) => t.path.equals(path))).go();
    }
  }
}
