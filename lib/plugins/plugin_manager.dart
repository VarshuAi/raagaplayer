import 'plugin.dart';
import 'provider_registry.dart';

class PluginManager {
  static final PluginManager _instance = PluginManager._internal();
  factory PluginManager() => _instance;
  PluginManager._internal();

  bool _initialized = false;

  Future<void> initializePlugins(List<MusicPlugin> defaultPlugins) async {
    if (_initialized) return;

    for (final plugin in defaultPlugins) {
      await plugin.initialize();
      ProviderRegistry().register(plugin);
    }
    _initialized = true;
  }
}
