import 'dart:async';

class AudioSessionManager {
  static final AudioSessionManager _instance = AudioSessionManager._internal();
  factory AudioSessionManager() => _instance;
  AudioSessionManager._internal();

  final _headsetDisconnectedController = StreamController<void>.broadcast();
  Stream<void> get onHeadsetDisconnected => _headsetDisconnectedController.stream;

  Future<void> configure() async {
    // Configure system audio sessions, ducking, bluetooth transitions, etc.
    // For now, this is a clean domain stub ready for audio session package integration.
  }

  void simulateHeadsetUnplug() {
    _headsetDisconnectedController.add(null);
  }

  void dispose() {
    _headsetDisconnectedController.close();
  }
}
