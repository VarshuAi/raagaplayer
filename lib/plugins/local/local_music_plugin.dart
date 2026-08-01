import '../../plugins/plugin.dart';
import '../../plugins/provider_manifest.dart';
import '../../plugins/provider_capabilities.dart';
import '../../music/data/datasource/local/local_music_data_source.dart';
import '../../music/data/adapters/local_provider_adapter.dart';
import '../../music/data/adapters/music_provider_adapter.dart';
import '../../core/database/app_database.dart';

class LocalMusicPlugin implements MusicPlugin {
  final AppDatabase database;
  late final LocalProviderAdapter _adapter;

  LocalMusicPlugin(this.database);

  @override
  int get apiVersion => 1;

  @override
  ProviderManifest get manifest => const ProviderManifest(
        id: 'local',
        displayName: 'Local Storage',
        version: '1.0.0',
        author: 'Raaga Team',
        capabilities: ProviderCapabilities(
          supportsOffline: true,
          supportsSearch: true,
          supportsLibrary: true,
        ),
      );

  @override
  Future<void> initialize() async {
    final dataSource = LocalMusicDataSource(database: database);
    _adapter = LocalProviderAdapter(dataSource);
  }

  @override
  MusicProviderAdapter get adapter => _adapter;
}
