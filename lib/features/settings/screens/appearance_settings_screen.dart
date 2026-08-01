import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/settings_provider.dart';
import '../widgets/settings_tile.dart';

class AppearanceSettingsScreen extends ConsumerWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          SettingsTile(
            leadingIcon: Icons.dark_mode_rounded,
            title: 'AMOLED Mode',
            subtitle: 'Pure black backgrounds for battery saving',
            trailing: Switch(
              value: settings.amoledMode,
              onChanged: (val) {
                notifier.updateSettings(settings.copyWith(amoledMode: val));
              },
            ),
            onTap: () {},
          ),
          SettingsTile(
            leadingIcon: Icons.color_lens_rounded,
            title: 'Dynamic Colors',
            subtitle: 'Apply dynamic artwork palette accent tints',
            trailing: Switch(
              value: settings.dynamicColors,
              onChanged: (val) {
                notifier.updateSettings(settings.copyWith(dynamicColors: val));
              },
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
