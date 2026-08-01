import '../../domain/entities/album.dart';

class AlbumModel extends Album {
  const AlbumModel({
    required super.name,
    required super.artist,
    required super.artworkUrl,
    required super.songCount,
    super.provider,
    super.providerId,
    super.createdAt,
    super.updatedAt,
    super.syncState,
    super.etag,
    super.version,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      name: json['name'] as String? ?? '',
      artist: json['artist'] as String? ?? 'Unknown Artist',
      artworkUrl: json['artwork_url'] ?? '',
      songCount: json['song_count'] as int? ?? 0,
      provider: json['provider'] as String? ?? 'local',
      providerId: json['provider_id'] as String? ?? '',
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'] as String) : null,
      syncState: json['sync_state'] as String? ?? 'synced',
      etag: json['etag'] as String?,
      version: json['version'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'artist': artist,
      'artwork_url': artworkUrl,
      'song_count': songCount,
      'provider': provider,
      'provider_id': providerId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'sync_state': syncState,
      'etag': etag,
      'version': version,
    };
  }
}
