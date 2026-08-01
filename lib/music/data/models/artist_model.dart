import '../../domain/entities/artist.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    required super.id,
    required super.name,
    required super.bio,
    required super.artworkUrl,
    required super.monthlyListeners,
    super.provider,
    super.providerId,
    super.createdAt,
    super.updatedAt,
    super.syncState,
    super.etag,
    super.version,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown Artist',
      bio: json['bio'] as String? ?? '',
      artworkUrl: json['artwork_url'] as String? ?? '',
      monthlyListeners: json['monthly_listeners'] as int? ?? 0,
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
      'bio': bio,
      'artwork_url': artworkUrl,
      'monthly_listeners': monthlyListeners,
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
