import 'song.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String artworkUrl;
  final List<Song> songs;
  final String creator;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.artworkUrl,
    required this.songs,
    required this.creator,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });

  Playlist copyWith({
    String? id,
    String? name,
    String? description,
    String? artworkUrl,
    List<Song>? songs,
    String? creator,
    String? provider,
    String? providerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncState,
    String? etag,
    int? version,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      songs: songs ?? this.songs,
      creator: creator ?? this.creator,
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
