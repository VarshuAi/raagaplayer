import 'package:http/http.dart' as http;
import '../../plugins/plugin.dart';
import '../../plugins/provider_manifest.dart';
import '../../plugins/provider_capabilities.dart';
import '../../music/data/datasource/remote/fastapi_music_data_source.dart';
import '../../music/data/adapters/remote_provider_adapter.dart';
import '../../music/data/adapters/music_provider_adapter.dart';

class FastApiMusicPlugin implements MusicPlugin {
  final http.Client client;
  late final RemoteProviderAdapter _adapter;

  FastApiMusicPlugin(this.client);

  @override
  int get apiVersion => 1;

  @override
  ProviderManifest get manifest => const ProviderManifest(
        id: 'fastapi',
        displayName: 'FastAPI Streaming',
        version: '1.0.0',
        author: 'Raaga Backend',
        capabilities: ProviderCapabilities(
          supportsStreaming: true,
          supportsSearch: true,
          supportsRadio: true,
          supportsRecommendations: true,
        ),
      );

  @override
  Future<void> initialize() async {
    final dataSource = FastApiMusicDataSource(client: client);
    _adapter = RemoteProviderAdapter(dataSource);
  }

  @override
  MusicProviderAdapter get adapter => _adapter;
}
