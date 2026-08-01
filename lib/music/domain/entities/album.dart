class Album {
  final String name;
  final String artist;
  final String artworkUrl;
  final int songCount;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const Album({
    required this.name,
    required this.artist,
    required this.artworkUrl,
    required this.songCount,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });

  Album copyWith({
    String? name,
    String? artist,
    String? artworkUrl,
    int? songCount,
    String? provider,
    String? providerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncState,
    String? etag,
    int? version,
  }) {
    return Album(
      name: name ?? this.name,
      artist: artist ?? this.artist,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      songCount: songCount ?? this.songCount,
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
