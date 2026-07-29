class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() => "ServerException: $message";
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);

  @override
  String toString() => "CacheException: $message";
}

class AudioEngineException implements Exception {
  final String message;
  const AudioEngineException(this.message);

  @override
  String toString() => "AudioEngineException: $message";
}
