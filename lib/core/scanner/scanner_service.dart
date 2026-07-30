import 'dart:async';
import 'dart:convert';
import 'media_scanner.dart';
import 'scanner_events.dart';
import '../database/app_database.dart';

class ScannerService {
  final AppDatabase database;
  late final MediaScanner _scanner;
  
  final _statusController = StreamController<ScannerEvent>.broadcast();
  Stream<ScannerEvent> get statusStream => _statusController.stream;

  ScannerService({required this.database}) {
    _scanner = MediaScanner(database: database);
    _scanner.scanEvents.listen((event) {
      _statusController.add(event);
    });
  }

  Future<void> triggerRescan() async {
    List<String> allowedFolders = [];
    try {
      final entry = await (database.select(database.settingsTable)
            ..where((t) => t.key.equals('app_settings_config')))
          .getSingleOrNull();
      if (entry != null) {
        final decoded = json.decode(entry.value);
        allowedFolders = List<String>.from(decoded['scanFolders'] ?? []);
      }
    } catch (_) {}

    await _scanner.scanDeviceMusic(allowedFolders: allowedFolders);
  }

  void dispose() {
    _scanner.dispose();
    _statusController.close();
  }
}
