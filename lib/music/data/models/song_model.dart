import '../../domain/entities/song.dart';

class SongModel extends Song {
  const SongModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.album,
    required super.artworkUrl,
    required super.sourceUrl,
    required super.duration,
    super.isLocal,
    super.isFavorite,
    super.provider,
    super.providerId,
    super.createdAt,
    super.updatedAt,
    super.syncState,
    super.etag,
    super.version,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    String image = (json['artwork_url'] ?? json['artworkUrl'] ?? json['thumbnail'] ?? json['image'] ?? json['perma_url'] ?? '').toString();
    if (image.contains('150x150')) image = image.replaceAll('150x150', '500x500');
    if (image.contains('50x50')) image = image.replaceAll('50x50', '500x500');

    String stream = (json['source_url'] ?? json['sourceUrl'] ?? json['streamingUrl'] ?? json['streamUrl'] ?? json['media_url'] ?? '').toString();
    final songId = (json['id'] ?? json['songid'] ?? '').toString();
    if (stream.isEmpty && songId.isNotEmpty) {
      stream = '/api/song/$songId/stream-url';
    }

    return SongModel(
      id: songId,
      title: (json['title'] ?? json['song'] ?? json['name'] ?? '').toString(),
      artist: (json['artist'] ?? json['singers'] ?? json['primary_artists'] ?? 'Unknown Artist').toString(),
      album: (json['album'] ?? '').toString(),
      artworkUrl: image,
      sourceUrl: stream,
      duration: Duration(seconds: json['duration_seconds'] as int? ?? json['duration'] as int? ?? (int.tryParse(json['duration']?.toString() ?? '180') ?? 180)),
      isLocal: json['is_local'] as bool? ?? json['isLocal'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? json['isFavorite'] as bool? ?? false,
      provider: json['provider'] as String? ?? 'remote',
      providerId: json['provider_id'] as String? ?? json['providerId'] as String? ?? '',
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
      'title': title,
      'artist': artist,
      'album': album,
      'artwork_url': artworkUrl,
      'source_url': sourceUrl,
      'duration_seconds': duration.inSeconds,
      'is_local': isLocal,
      'is_favorite': isFavorite,
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
