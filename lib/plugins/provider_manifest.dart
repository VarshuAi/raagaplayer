import 'provider_capabilities.dart';

class ProviderManifest {
  final String id;
  final String displayName;
  final String version;
  final String author;
  final Uri? website;
  final ProviderCapabilities capabilities;

  const ProviderManifest({
    required this.id,
    required this.displayName,
    required this.version,
    required this.author,
    this.website,
    required this.capabilities,
  });
}
