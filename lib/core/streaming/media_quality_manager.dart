import '../database/app_database.dart';

enum MediaQualityProfile {
  low,
  medium,
  high,
  veryHigh,
  lossless
}

class MediaQualityManager {
  final AppDatabase database;

  MediaQualityManager({required this.database});

  Future<MediaQualityProfile> getActiveQualityProfile({required bool isWifi, required bool isRoaming}) async {
    final key = isWifi ? 'quality_wifi' : (isRoaming ? 'quality_roaming' : 'quality_mobile');
    final query = await (database.select(database.mediaQuality)..where((t) => t.key.equals(key))).get();
    if (query.isNotEmpty) {
      return _parseProfile(query.first.value);
    }

    if (isWifi) return MediaQualityProfile.high;
    if (isRoaming) return MediaQualityProfile.low;
    return MediaQualityProfile.medium;
  }

  MediaQualityProfile _parseProfile(String value) {
    switch (value.toLowerCase()) {
      case 'low': return MediaQualityProfile.low;
      case 'medium': return MediaQualityProfile.medium;
      case 'high': return MediaQualityProfile.high;
      case 'very_high': return MediaQualityProfile.veryHigh;
      case 'lossless': return MediaQualityProfile.lossless;
      default: return MediaQualityProfile.medium;
    }
  }
}
