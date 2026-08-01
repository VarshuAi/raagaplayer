class UserProfile {
  final String userId;
  final String displayName;
  final String? avatarUrl;
  final String? email;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const UserProfile({
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    this.email,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });
}
