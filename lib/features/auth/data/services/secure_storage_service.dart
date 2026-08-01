import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  File? _secureFile;

  Future<File> get _file async {
    if (_secureFile != null) return _secureFile!;
    final directory = await getApplicationDocumentsDirectory();
    _secureFile = File(p.join(directory.path, '.secure_tokens.bin'));
    return _secureFile!;
  }

  Future<void> write(String key, String value) async {
    final file = await _file;
    Map<String, String> data = {};
    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        final decrypted = _decrypt(content);
        data = Map<String, String>.from(json.decode(decrypted));
      } catch (_) {}
    }
    data[key] = value;
    final encrypted = _encrypt(json.encode(data));
    await file.writeAsString(encrypted);
  }

  Future<String?> read(String key) async {
    final file = await _file;
    if (!await file.exists()) return null;
    try {
      final content = await file.readAsString();
      final decrypted = _decrypt(content);
      final data = Map<String, String>.from(json.decode(decrypted));
      return data[key];
    } catch (_) {
      return null;
    }
  }

  Future<void> delete(String key) async {
    final file = await _file;
    if (!await file.exists()) return;
    try {
      final content = await file.readAsString();
      final decrypted = _decrypt(content);
      final data = Map<String, String>.from(json.decode(decrypted));
      data.remove(key);
      final encrypted = _encrypt(json.encode(data));
      await file.writeAsString(encrypted);
    } catch (_) {}
  }

  String _encrypt(String plainText) {
    final bytes = utf8.encode(plainText);
    final encrypted = bytes.map((b) => b ^ 42).toList();
    return base64.encode(encrypted);
  }

  String _decrypt(String cipherText) {
    final bytes = base64.decode(cipherText);
    final decrypted = bytes.map((b) => b ^ 42).toList();
    return utf8.decode(decrypted);
  }
}
