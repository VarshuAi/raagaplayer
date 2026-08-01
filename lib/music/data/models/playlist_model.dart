import '../../domain/entities/playlist.dart';
import 'song_model.dart';

class PlaylistModel extends Playlist {
  const PlaylistModel({
    required super.id,
    required super.name,
    required super.description,
    required super.artworkUrl,
    required super.songs,
    required super.creator,
    super.provider,
    super.providerId,
    super.createdAt,
    super.updatedAt,
    super.syncState,
    super.etag,
    super.version,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    final songList = (json['songs'] as List<dynamic>?)
            ?.map((e) => SongModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return PlaylistModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Untitled',
      description: json['description'] as String? ?? '',
      artworkUrl: json['artwork_url'] as String? ?? '',
      songs: songList,
      creator: json['creator'] as String? ?? 'Raaga User',
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
      'id': id,
      'name': name,
      'description': description,
      'artwork_url': artworkUrl,
      'songs': songs.map((e) => (e as SongModel).toJson()).toList(),
      'creator': creator,
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
