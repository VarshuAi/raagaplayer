import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../plugins/provider_registry.dart';

class ProviderManagementScreen extends ConsumerStatefulWidget {
  const ProviderManagementScreen({super.key});

  @override
  ConsumerState<ProviderManagementScreen> createState() => _ProviderManagementScreenState();
}

class _ProviderManagementScreenState extends ConsumerState<ProviderManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final registry = ProviderRegistry();
    final plugins = registry.registeredPlugins;
    final activeId = registry.activeProviderId;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plugins.length,
        itemBuilder: (context, index) {
          final plugin = plugins[index];
          final manifest = plugin.manifest;
          final isActive = manifest.id == activeId;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: isActive ? theme.colorScheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        manifest.displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: isActive,
                        onChanged: (val) {
                          if (val) {
                            setState(() {
                              registry.setActiveProvider(manifest.id);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Switched active provider to ${manifest.displayName}')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version: ${manifest.version} • Author: ${manifest.author}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Divider(height: 24),
                  Text(
                    'Capabilities:',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      if (manifest.capabilities.supportsStreaming)
                        _capabilityChip('Streaming', theme),
                      if (manifest.capabilities.supportsOffline)
                        _capabilityChip('Offline Play', theme),
                      if (manifest.capabilities.supportsDownload)
                        _capabilityChip('Downloads', theme),
                      if (manifest.capabilities.supportsSearch)
                        _capabilityChip('Search', theme),
                      if (manifest.capabilities.supportsRadio)
                        _capabilityChip('Radio', theme),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _capabilityChip(String label, ThemeData theme) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 11)),
      backgroundColor: theme.colorScheme.surfaceVariant,
      side: BorderSide.none,
      padding: EdgeInsets.zero,
    );
  }
}
