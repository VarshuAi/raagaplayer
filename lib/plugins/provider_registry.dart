import 'plugin.dart';

class ProviderRegistry {
  static final ProviderRegistry _instance = ProviderRegistry._internal();
  factory ProviderRegistry() => _instance;
  ProviderRegistry._internal();

  final Map<String, MusicPlugin> _registeredPlugins = {};
  String _activeProviderId = 'fastapi';

  void register(MusicPlugin plugin) {
    if (plugin.apiVersion != 1) {
      throw Exception('Plugin apiVersion mismatch. Expected: 1, Found: ${plugin.apiVersion}');
    }
    _registeredPlugins[plugin.manifest.id] = plugin;
  }

  void setActiveProvider(String id) {
    if (!_registeredPlugins.containsKey(id)) {
      throw Exception('Provider plugin $id not found in registry.');
    }
    _activeProviderId = id;
  }

  MusicPlugin get activePlugin {
    return _registeredPlugins[_activeProviderId] ?? 
           _registeredPlugins['fastapi'] ?? 
           _registeredPlugins.values.first;
  }

  List<MusicPlugin> get registeredPlugins => _registeredPlugins.values.toList();
  String get activeProviderId => _activeProviderId;
}
