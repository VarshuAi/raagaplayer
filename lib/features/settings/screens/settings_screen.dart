import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _tapCount = 0;

  void _onAboutTap() {
    _tapCount++;
    if (_tapCount >= 7) {
      _tapCount = 0;
      context.push('/settings/developer');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Developer mode enabled!')),
      );
    } else if (_tapCount > 2) {
      final remaining = 7 - _tapCount;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tap $remaining more times to unlock Developer Console.'),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

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
                onTap: () => context.push('/settings/appearance'),
              ),
              SettingsTile(
                leadingIcon: Icons.play_circle_outline_rounded,
                title: 'Playback',
                subtitle: 'Gapless, resume options, crossfade',
                onTap: () => context.push('/settings/playback'),
              ),
            ],
          ),
          SettingsSection(
            title: 'Data & Services',
            children: [
              SettingsTile(
                leadingIcon: Icons.library_music_rounded,
                title: 'Library Settings',
                subtitle: 'Online catalog, cache management',
                onTap: () => context.push('/settings/library'),
              ),
              SettingsTile(
                leadingIcon: Icons.backup_rounded,
                title: 'Backup & Restore',
                subtitle: 'Local .raaga_backup exports/imports',
                onTap: () => context.push('/settings/backup'),
              ),
              SettingsTile(
                leadingIcon: Icons.download_rounded,
                title: 'Downloads',
                subtitle: 'Manage downloaded offline tracks',
                onTap: () => context.push('/downloads'),
              ),
            ],
          ),
          SettingsSection(
            title: 'About',
            children: [
              SettingsTile(
                leadingIcon: Icons.info_outline_rounded,
                title: 'Raaga Music Player',
                subtitle: 'Version 7.0.0 (Raaga Online Cloud Engine)',
                onTap: _onAboutTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
