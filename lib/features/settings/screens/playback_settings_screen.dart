import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/settings_provider.dart';
import '../widgets/settings_tile.dart';

class PlaybackSettingsScreen extends ConsumerWidget {
  const PlaybackSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Playback'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          SettingsTile(
            leadingIcon: Icons.hdr_strong_rounded,
            title: 'Gapless Playback',
            subtitle: 'Smooth transitions between tracks',
            trailing: Switch(
              value: settings.gaplessPlayback,
              onChanged: (val) {
                notifier.updateSettings(settings.copyWith(gaplessPlayback: val));
              },
            ),
            onTap: () {},
          ),
          SettingsTile(
            leadingIcon: Icons.restore_rounded,
            title: 'Resume Playback',
            subtitle: 'Start playback where you left off on boot',
            trailing: Switch(
              value: settings.resumePlayback,
              onChanged: (val) {
                notifier.updateSettings(settings.copyWith(resumePlayback: val));
              },
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Crossfade Duration'),
            subtitle: Slider(
              value: settings.crossfadeDurationSec,
              min: 0.0,
              max: 10.0,
              divisions: 10,
              label: '${settings.crossfadeDurationSec.toInt()}s',
              onChanged: (val) {
                notifier.updateSettings(settings.copyWith(crossfadeDurationSec: val));
              },
            ),
          ),
        ],
      ),
    );
  }
}
