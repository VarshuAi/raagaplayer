abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class AudioPlaybackFailure extends Failure {
  const AudioPlaybackFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure([super.message = "No internet connection detected."]);
}
