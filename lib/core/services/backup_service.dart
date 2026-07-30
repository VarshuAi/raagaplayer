import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../database/app_database.dart';

class BackupService {
  final AppDatabase database;

  BackupService({required this.database});

  Future<File> createBackup({String? password}) async {
    // 1. Fetch tables data to package
    final playlists = await database.select(database.playlists).get();
    final songs = await database.select(database.songs).get();
    final history = await database.select(database.history).get();
    final queue = await database.select(database.queueItems).get();

    final backupPayload = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'playlists': playlists.map((p) => {'id': p.id, 'name': p.name, 'creator': p.creator}).toList(),
      'songs': songs.map((s) => {'id': s.id, 'title': s.title, 'artist': s.artist, 'path': s.path}).toList(),
      'history': history.map((h) => {'songId': h.songId, 'playedAt': h.playedAt.toIso8601String()}).toList(),
      'queue': queue.map((q) => {'songId': q.songId, 'sequence': q.sequence}).toList(),
    };

    final jsonStr = json.encode(backupPayload);
    
    // Encrypt contents if password specified
    final String content = password != null ? _obscure(jsonStr, password) : jsonStr;

    final documentsDir = await getApplicationDocumentsDirectory();
    final backupFile = File(p.join(documentsDir.path, 'raaga_${DateTime.now().millisecondsSinceEpoch}.raaga_backup'));
    return backupFile.writeAsString(content);
  }

  String _obscure(String text, String key) {
    // Simple XOR key obscuring helper staying under dependency/isolate boundaries
    final keyBytes = utf8.encode(key);
    final textBytes = utf8.encode(text);
    final result = List<int>.filled(textBytes.length, 0);

    for (int i = 0; i < textBytes.length; i++) {
      result[i] = textBytes[i] ^ keyBytes[i % keyBytes.length];
    }
    return base64.encode(result);
  }
}
