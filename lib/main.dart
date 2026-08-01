import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audio_service/audio_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';

import 'package:http/http.dart' as http;
import 'core/database/app_database.dart';
import 'music/presentation/providers/music_providers.dart';
import 'plugins/plugin_manager.dart';
import 'plugins/local/local_music_plugin.dart';
import 'plugins/fastapi/fastapi_music_plugin.dart';
import 'features/download/data/services/download_manager.dart';
import 'core/audio/raaga_audio_handler.dart';
import 'core/playback/playback_engine.dart';
import 'features/player/provider/artwork_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase.instance();
  final client = http.Client();

  DownloadManager().initialize(db);

  await PluginManager().initializePlugins([
    LocalMusicPlugin(db),
    FastApiMusicPlugin(client),
  ]);

  try {
    if (Platform.isAndroid) {
      await Permission.notification.request();
    }
  } catch (_) {}

  try {
    await AudioService.init(
      builder: () => RaagaAudioHandler(PlaybackEngine.sharedPlayer),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.raaga.music.channel.audio',
        androidNotificationChannelName: 'A1 Raaga Music Playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
        androidNotificationIcon: 'mipmap/ic_launcher',
        androidShowNotificationBadge: true,
      ),
    );
  } catch (e) {
    print('AudioService init note: $e');
  }

  final router = createRouter(initialLocation: '/splash');

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        httpClientProvider.overrideWithValue(client),
      ],
      child: RaagaApp(router: router),
    ),
  );
}

class RaagaApp extends ConsumerWidget {
  final dynamic router;
  const RaagaApp({super.key, required this.router});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(artworkPaletteProvider);
    final primaryColor = palette.vibrantColor != const Color(0xFF8B5CF6)
        ? palette.vibrantColor
        : (palette.dominantColor != const Color(0xFF15161A) ? palette.dominantColor : const Color(0xFF8B5CF6));

    return MaterialApp.router(
      title: 'A1 Raaga',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkWithPrimary(primaryColor),
      routerConfig: router,
    );
  }
}
