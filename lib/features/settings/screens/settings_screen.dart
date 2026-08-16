import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_section.dart';
import '../widgets/equalizer_sheet.dart';
import '../../../core/widgets/sheets/raaga_bottom_sheet.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';

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

  void _showDeveloperProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => RaagaBottomSheet(
        title: 'Developer Info 💻',
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Developer Avatar Card
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.primary,
                      context.colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '⚡',
                    style: TextStyle(fontSize: 38),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'VarshuAi',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              Text(
                'Lead Developer of Raaga Player',
                style: TextStyle(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 28),

              // Social links list
              _buildSocialTile(
                context,
                icon: Icons.camera_alt_outlined,
                label: 'Instagram',
                username: '@being.version',
                url: 'https://instagram.com/being.version',
                color: Colors.pinkAccent,
              ),
              const SizedBox(height: 12),
              _buildSocialTile(
                context,
                icon: Icons.code_rounded,
                label: 'GitHub',
                username: 'varshuai',
                url: 'https://github.com/varshuai',
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String username,
    required String url,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.12),
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(username),
        trailing: const Icon(Icons.open_in_new_rounded, size: 20),
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      ),
    );
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
              SettingsTile(
                leadingIcon: Icons.equalizer_rounded,
                title: 'Equalizer',
                subtitle: 'Bass boost, dynamic frequency bands',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const EqualizerSheet(),
                  );
                },
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
              SettingsTile(
                leadingIcon: Icons.code_rounded,
                title: 'Developer Profile',
                subtitle: 'Made by VarshuAi',
                onTap: () => _showDeveloperProfileBottomSheet(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
