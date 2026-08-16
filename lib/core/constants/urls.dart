class AppUrls {
  AppUrls._();

  // Obfuscated base API URL using compile-time XOR encryption key 0x5A (90)
  // [104, 116, 116, 112, 115, 58, 47, 47, 109, 117, 115, 105, 99, 111, 45, 110, 97, 53, 101, 46, 111, 110, 114, 101, 110, 100, 101, 114, 46, 99, 111, 109]
  static final List<int> _obfuscatedUrlBytes = [50, 46, 46, 42, 41, 96, 117, 117, 55, 47, 41, 51, 57, 53, 119, 52, 59, 111, 63, 116, 53, 52, 40, 63, 52, 62, 63, 40, 116, 57, 53, 55];

  static String get baseApiUrl {
    return String.fromCharCodes(_obfuscatedUrlBytes.map((b) => b ^ 0x5A));
  }

  static const String trendingRecommendations = '/api/recommendations/discover';
  static const String searchAutocomplete = '/api/suggest';
  static const String searchMusic = '/api/search';
  static const String nextSuggestions = '/api/next';
  static const String streamUrl = '/api/stream';

  static String get fallbackStream {
    return String.fromCharCodes(_obfuscatedUrlBytes.map((b) => b ^ 0x5A));
  }
}
