import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../navigation/app_routes.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          SettingsSection(
            title: 'Personalization',
            children: [
              SettingsTile(
                leadingIcon: Icons.palette_rounded,
                title: 'Appearance',
                subtitle: 'Themes, dynamic colors, corner radius',
                onTap: () => context.push('/library/settings/appearance'),
              ),
              SettingsTile(
                leadingIcon: Icons.play_circle_outline_rounded,
                title: 'Playback',
                subtitle: 'Gapless, resume options, crossfade',
                onTap: () => context.push('/library/settings/playback'),
              ),
            ],
          ),
          SettingsSection(
            title: 'Data & Library',
            children: [
              SettingsTile(
                leadingIcon: Icons.library_music_rounded,
                title: 'Library Settings',
                subtitle: 'Rescan storage, cache management',
                onTap: () => context.push('/library/settings/library'),
              ),
              SettingsTile(
                leadingIcon: Icons.backup_rounded,
                title: 'Backup & Restore',
                subtitle: 'Local .raaga_backup exports/imports',
                onTap: () => context.push('/library/settings/backup'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
