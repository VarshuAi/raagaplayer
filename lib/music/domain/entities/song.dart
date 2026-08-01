class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String artworkUrl;
  final String sourceUrl;
  final Duration duration;
  final bool isLocal;
  final bool isFavorite;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.artworkUrl,
    required this.sourceUrl,
    required this.duration,
    this.isLocal = false,
    this.isFavorite = false,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? artworkUrl,
    String? sourceUrl,
    Duration? duration,
    bool? isLocal,
    bool? isFavorite,
    String? provider,
    String? providerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncState,
    String? etag,
    int? version,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      duration: duration ?? this.duration,
      isLocal: isLocal ?? this.isLocal,
      isFavorite: isFavorite ?? this.isFavorite,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      etag: etag ?? this.etag,
      version: version ?? this.version,
    );
  }
}
