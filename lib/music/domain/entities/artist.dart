class Artist {
  final String id;
  final String name;
  final String bio;
  final String artworkUrl;
  final int monthlyListeners;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const Artist({
    required this.id,
    required this.name,
    required this.bio,
    required this.artworkUrl,
    required this.monthlyListeners,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });

  Artist copyWith({
    String? id,
    String? name,
    String? bio,
    String? artworkUrl,
    int? monthlyListeners,
    String? provider,
    String? providerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncState,
    String? etag,
    int? version,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      monthlyListeners: monthlyListeners ?? this.monthlyListeners,
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
