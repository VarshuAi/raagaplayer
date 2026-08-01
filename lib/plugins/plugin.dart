import '../music/data/adapters/music_provider_adapter.dart';
import 'provider_manifest.dart';

abstract class MusicPlugin {
  int get apiVersion;
  ProviderManifest get manifest;

  Future<void> initialize();
  MusicProviderAdapter get adapter;
}
