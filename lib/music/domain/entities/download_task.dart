enum DownloadStatus {
  pending,
  downloading,
  completed,
  failed,
  paused
}

class DownloadTask {
  final String songId;
  final DownloadStatus status;
  final double progress; // 0.0 to 1.0
  final String? localFilePath;
  final String? error;

  // Sync-ready metadata fields
  final String provider;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String syncState;
  final String? etag;
  final int version;

  const DownloadTask({
    required this.songId,
    required this.status,
    required this.progress,
    this.localFilePath,
    this.error,
    this.provider = 'local',
    this.providerId = '',
    this.createdAt,
    this.updatedAt,
    this.syncState = 'synced',
    this.etag,
    this.version = 1,
  });

  DownloadTask copyWith({
    String? songId,
    DownloadStatus? status,
    double? progress,
    String? localFilePath,
    String? error,
    String? provider,
    String? providerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncState,
    String? etag,
    int? version,
  }) {
    return DownloadTask(
      songId: songId ?? this.songId,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      localFilePath: localFilePath ?? this.localFilePath,
      error: error ?? this.error,
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
