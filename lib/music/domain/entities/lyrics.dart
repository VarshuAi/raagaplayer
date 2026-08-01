class LyricLine {
  final Duration timeStamp;
  final String text;

  const LyricLine(this.timeStamp, this.text);
}

class Lyrics {
  final String songId;
  final String content;
  final List<LyricLine> lines;
  final bool isSynced;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const Lyrics({
    required this.songId,
    required this.content,
    required this.lines,
    this.isSynced = false,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });
}
