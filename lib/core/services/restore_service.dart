import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import '../database/app_database.dart';

class RestoreService {
  final AppDatabase database;

  RestoreService({required this.database});

  Future<bool> restoreBackup(String backupFilePath, {String? password}) async {
    final file = File(backupFilePath);
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    
    try {
      final String jsonStr = password != null ? _deobscure(content, password) : content;
      final Map<String, dynamic> payload = json.decode(jsonStr);

      if (payload['version'] != 1) return false; // Version validation

      await database.transaction(() async {
        // Clear tables
        await database.delete(database.playlists).go();
        await database.delete(database.history).go();
        await database.delete(database.queueItems).go();

        // Restore Playlists
        final List<dynamic> playlists = payload['playlists'] ?? [];
        for (final p in playlists) {
          await database.into(database.playlists).insert(
                PlaylistsCompanion(
                  id: Value(p['id']),
                  name: Value(p['name']),
                  creator: Value(p['creator'] ?? 'User'),
                ),
              );
        }

        // Restore History
        final List<dynamic> history = payload['history'] ?? [];
        for (final h in history) {
          await database.into(database.history).insert(
                HistoryCompanion(
                  songId: Value(h['songId']),
                  playedAt: Value(DateTime.parse(h['playedAt'])),
                ),
              );
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  String _deobscure(String base64Text, String key) {
    final keyBytes = utf8.encode(key);
    final textBytes = base64.decode(base64Text);
    final result = List<int>.filled(textBytes.length, 0);

    for (int i = 0; i < textBytes.length; i++) {
      result[i] = textBytes[i] ^ keyBytes[i % keyBytes.length];
    }
    return utf8.decode(result);
  }
}
