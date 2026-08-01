import '../database/app_database.dart' as db;

class LibraryIssue {
  final String title;
  final String description;
  final String category; // 'duplicates', 'metadata', 'files', 'artwork'
  final List<String> affectedSongIds;
  final String suggestion;

  LibraryIssue({
    required this.title,
    required this.description,
    required this.category,
    required this.affectedSongIds,
    required this.suggestion,
  });
}

class LibraryIntelligence {
  final db.AppDatabase _db;

  LibraryIntelligence(this._db);

  Future<List<LibraryIssue>> scanLibrary() async {
    final songs = await _db.select(_db.songs).get();
    final issues = <LibraryIssue>[];

    if (songs.isEmpty) return issues;

    final duplicateIds = <String>[];
    final songKeyMap = <String, db.Song>{};

    for (final s in songs) {
      final key = "${s.title.toLowerCase().trim()}_${((s.durationMs ?? 0) / 2000).round()}";
      if (songKeyMap.containsKey(key)) {
        final existing = songKeyMap[key]!;
        if (existing.path != s.path) {
          duplicateIds.add(s.id);
        }
      } else {
        songKeyMap[key] = s;
      }
    }

    if (duplicateIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Duplicate Tracks Detected",
        description: "You have ${duplicateIds.length} duplicate songs in your library occupying extra storage.",
        category: "duplicates",
        affectedSongIds: duplicateIds,
        suggestion: "Remove duplicate audio files to save device memory.",
      ));
    }

    final unknownArtistIds = songs
        .where((s) => s.artist.isEmpty || RegExp(r"unknown|various", caseSensitive: false).hasMatch(s.artist))
        .map((s) => s.id)
        .toList();

    if (unknownArtistIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Missing or Unknown Artists",
        description: "Found ${unknownArtistIds.length} tracks with missing or generic artist details.",
        category: "metadata",
        affectedSongIds: unknownArtistIds,
        suggestion: "Edit metadata details to group your tracks under correct artist indexes.",
      ));
    }

    final unknownAlbumIds = songs
        .where((s) => s.album.isEmpty || RegExp(r"unknown|single", caseSensitive: false).hasMatch(s.album))
        .map((s) => s.id)
        .toList();

    if (unknownAlbumIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Unknown Albums",
        description: "Found ${unknownAlbumIds.length} tracks mapped to unknown or fallback album tags.",
        category: "metadata",
        affectedSongIds: unknownAlbumIds,
        suggestion: "Unify track metadata tags to organize them into coherent albums.",
      ));
    }

    final missingArtworkIds = songs
        .where((s) => s.artworkUrl == null || s.artworkUrl!.isEmpty)
        .map((s) => s.id)
        .toList();

    if (missingArtworkIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Missing Album Cover Art",
        description: "Found ${missingArtworkIds.length} songs missing cover images.",
        category: "artwork",
        affectedSongIds: missingArtworkIds,
        suggestion: "Fetch high-resolution embedded or network artwork for these tracks.",
      ));
    }

    final albumCasingMap = <String, Set<String>>{};
    for (final s in songs) {
      final clean = s.album.trim().toLowerCase();
      if (clean.isNotEmpty) {
        albumCasingMap.putIfAbsent(clean, () => {}).add(s.album);
      }
    }

    final inconsistentAlbumIds = <String>[];
    for (final entry in albumCasingMap.entries) {
      if (entry.value.length > 1) {
        final targetNames = entry.value;
        inconsistentAlbumIds.addAll(
          songs.where((s) => targetNames.contains(s.album)).map((s) => s.id)
        );
      }
    }

    if (inconsistentAlbumIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Inconsistent Album Casing",
        description: "Found ${inconsistentAlbumIds.length} tracks with slight casing/whitespace discrepancies in album names.",
        category: "metadata",
        affectedSongIds: inconsistentAlbumIds,
        suggestion: "Unify the capitalization and spelling of these album names.",
      ));
    }

    final lowBitrateIds = songs
        .where((s) => s.bitrate != null && s.bitrate! > 0 && s.bitrate! < 128)
        .map((s) => s.id)
        .toList();

    if (lowBitrateIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Low Quality Encodes",
        description: "Found ${lowBitrateIds.length} audio tracks with bitrates lower than 128 kbps.",
        category: "files",
        affectedSongIds: lowBitrateIds,
        suggestion: "Replace these files with higher bitrate encodes (e.g. 256kbps+ or lossless) for better fidelity.",
      ));
    }

    final largeFileIds = songs.where((s) {
      if (s.bitrate == null || s.durationMs == null) return false;
      final sizeMb = (s.durationMs! / 1000) * (s.bitrate! * 1000 / 8) / (1024 * 1024);
      return sizeMb > 15.0;
    }).map((s) => s.id).toList();

    if (largeFileIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Large Audio Files",
        description: "Found ${largeFileIds.length} files that are larger than 15 MB.",
        category: "files",
        affectedSongIds: largeFileIds,
        suggestion: "These files consume significant storage space. Consider transcoding or checking if they are full-length DJ mixes.",
      ));
    }

    final unknownGenreIds = songs
        .where((s) => s.genre == null || s.genre!.isEmpty || RegExp(r"unknown", caseSensitive: false).hasMatch(s.genre!))
        .map((s) => s.id)
        .toList();

    if (unknownGenreIds.isNotEmpty) {
      issues.add(LibraryIssue(
        title: "Unknown Genres",
        description: "Found ${unknownGenreIds.length} songs with undefined genres.",
        category: "metadata",
        affectedSongIds: unknownGenreIds,
        suggestion: "Tag these songs to improve genre-based mix recommendations.",
      ));
    }

    return issues;
  }
}
