abstract class ScannerEvent {
  const ScannerEvent();
}

class ScanningStarted extends ScannerEvent {
  const ScanningStarted();
}

class ScanningFolder extends ScannerEvent {
  final String folderPath;
  const ScanningFolder(this.folderPath);
}

class SongIndexed extends ScannerEvent {
  final String title;
  final String artist;
  const SongIndexed({required this.title, required this.artist});
}

class SongUpdated extends ScannerEvent {
  final String title;
  const SongUpdated(this.title);
}

class SongRemoved extends ScannerEvent {
  final String path;
  const SongRemoved(this.path);
}

class ArtworkGenerated extends ScannerEvent {
  final String songId;
  const ArtworkGenerated(this.songId);
}

class ScanCompleted extends ScannerEvent {
  final int totalSongsScanned;
  const ScanCompleted(this.totalSongsScanned);
}

class ScanFailed extends ScannerEvent {
  final String error;
  const ScanFailed(this.error);
}
