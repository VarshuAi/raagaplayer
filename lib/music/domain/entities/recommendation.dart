import 'song.dart';

class Recommendation {
  final String title;
  final String reason; // e.g., 'Based on your favorites'
  final List<Song> songs;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const Recommendation({
    required this.title,
    required this.reason,
    required this.songs,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });
}
