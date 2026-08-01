import '../database/app_database.dart';
import '../services/playback_restore.dart';
import '../services/permission_service.dart';
import '../audio/just_audio_engine.dart';
import '../audio/queue_manager.dart';

class AppInitializer {
  final AppDatabase database;
  final JustAudioEngine audioEngine;
  late final PlaybackRestoreService _restoreService;

  AppInitializer({
    required this.database,
    required this.audioEngine,
  }) {
    _restoreService = PlaybackRestoreService(database: database);
  }

  Future<void> initialize() async {
    // 0. Initialize FTS virtual tables
    await database.initFts();

    // 1. Initialise local audio configurations
    // The AudioEngine handles inner audio session mappings on start

    // 2. Request core permissions
    await PermissionService.checkAndRequestAll();

    // 3. Restore queue items and active track states if present
    QueueManager().setRestoreService(_restoreService);
    final restoredQueue = await _restoreService.restoreQueue();
    if (restoredQueue.isNotEmpty) {
      QueueManager().addAll(restoredQueue);
    }

    final lastState = await _restoreService.restoreLastState();
    if (lastState != null) {
      final songId = lastState['currentSongId'] as String?;
      if (songId != null) {
        final match = restoredQueue.where((s) => s.id == songId);
        if (match.isNotEmpty) {
          // Re-load the last active track into the player engine without playing
          await audioEngine.setSource(match.first.sourceUrl);
          await audioEngine.seek(lastState['position'] as Duration);
        }
      }
    }
  }
}
