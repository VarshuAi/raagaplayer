class ProviderCapabilities {
  final bool supportsStreaming;
  final bool supportsDownload;
  final bool supportsLyrics;
  final bool supportsRadio;
  final bool supportsRecommendations;
  final bool supportsOffline;
  final bool supportsSearch;
  final bool supportsLibrary;
  final bool supportsAuthentication;
  final bool supportsSync;

  const ProviderCapabilities({
    this.supportsStreaming = false,
    this.supportsDownload = false,
    this.supportsLyrics = false,
    this.supportsRadio = false,
    this.supportsRecommendations = false,
    this.supportsOffline = false,
    this.supportsSearch = false,
    this.supportsLibrary = false,
    this.supportsAuthentication = false,
    this.supportsSync = false,
  });
}
