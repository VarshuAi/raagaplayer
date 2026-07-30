import 'dart:async';
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
    // Run the scanner in a background task
    // Using simple async execution, keeping database operations thread-safe
    await _scanner.scanDeviceMusic();
  }

  void dispose() {
    _scanner.dispose();
    _statusController.close();
  }
}
