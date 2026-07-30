import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/models/app_settings.dart';
import '../../home/screens/home_screen.dart';

class SettingsNotifier extends StateNotifier<AppSettings> {
  final Ref _ref;

  SettingsNotifier(this._ref) : super(const AppSettings()) {
    _loadFromDatabase();
  }

  Future<void> _loadFromDatabase() async {
    try {
      final db = _ref.read(databaseProvider);
      final entry = await (db.select(db.settingsTable)
            ..where((t) => t.key.equals('app_settings_config')))
          .getSingleOrNull();

      if (entry != null) {
        final decoded = json.decode(entry.value);
        state = AppSettings.fromJson(decoded);
      }
    } catch (_) {}
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    state = newSettings;
    try {
      final db = _ref.read(databaseProvider);
      final jsonStr = json.encode(newSettings.toJson());
      await db.into(db.settingsTable).insertOnConflictUpdate(
            SettingsTableCompanion(
              key: const Value('app_settings_config'),
              value: Value(jsonStr),
            ),
          );
    } catch (_) {}
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier(ref);
});
