import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/database/app_database.dart';
import '../../core/constants/urls.dart';
import '../data/models/song_model.dart';

class CloudSyncCoordinator {
  final AppDatabase database;
  final http.Client httpClient;

  CloudSyncCoordinator({
    required this.database,
    required this.httpClient,
  });

  Future<void> syncCloudLibrary() async {
    final pendingOps = await database.select(database.syncQueue).get();
    for (final op in pendingOps) {
      final success = await _dispatchSyncOperation(op);
      if (success) {
        await (database.delete(database.syncQueue)..where((t) => t.id.equals(op.id))).go();
      } else {
        await database.customStatement('''
          UPDATE sync_queue
          SET retries = retries + 1
          WHERE id = ?;
        ''', [op.id]);
      }
    }

    try {
      final response = await httpClient.get(
        Uri.parse('${AppUrls.baseApiUrl}/sync/favorites'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true && data['favorites'] != null) {
          for (final f in data['favorites']) {
            final song = SongModel.fromJson(f);
            await database.customStatement('''
              INSERT OR REPLACE INTO songs (id, title, artist, album, duration, duration_ms, path, folder, is_local, is_favorite)
              VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
            ''', [
              song.id,
              song.title,
              song.artist,
              song.album,
              song.duration.toString(),
              song.duration.inMilliseconds,
              song.sourceUrl,
              'cloud',
              false,
              true
            ]);
          }
        }
      }
    } catch (_) {}
  }

  Future<bool> _dispatchSyncOperation(SyncQueueData op) async {
    try {
      final response = await httpClient.post(
        Uri.parse('${AppUrls.baseApiUrl}/sync/dispatch'),
        body: json.encode({
          'table': op.syncTableName,
          'record_id': op.recordId,
          'operation': op.operation,
          'payload': op.payload,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<void> queueSyncOperation({
    required String tableName,
    required String recordId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    await database.customStatement('''
      INSERT INTO sync_queue (table_name, record_id, operation, payload, retries)
      VALUES (?, ?, ?, ?, ?);
    ''', [tableName, recordId, operation, json.encode(payload), 0]);
  }
}
