class AppUrls {
  AppUrls._();

  // Vercel Serverless Production API URL (0ms cold start)
  static String get baseApiUrl {
    return 'https://music-backend-pink-one.vercel.app';
  }

  static const List<String> serverPool = [
    'https://music-backend-pink-one.vercel.app',
  ];

  static bool get useProxyServer => true;

  static const String trendingRecommendations = '/api/feed';
  static const String searchAutocomplete = '/api/suggest';
  static const String searchMusic = '/api/search';
  static const String nextSuggestions = '/api/next';
  static const String streamUrl = '/api/stream';

  static String get fallbackStream {
    return 'https://music-backend-pink-one.vercel.app';
  }
}
