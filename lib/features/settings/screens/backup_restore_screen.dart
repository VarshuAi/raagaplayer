import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../home/screens/home_screen.dart';
import '../../../core/services/backup_service.dart';
import '../../../core/services/restore_service.dart';
import '../../../core/widgets/feedback/raaga_feedback.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  List<File> _availableBackups = [];

  @override
  void initState() {
    super.initState();
    _loadBackupsList();
  }

  Future<void> _loadBackupsList() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final list = documentsDir.listSync();
    setState(() {
      _availableBackups = list
          .whereType<File>()
          .where((f) => f.path.endsWith('.raaga_backup'))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Local Backups Only',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Backup settings, favorites, and playlists to the local storage. Restoring will replace current lists.',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final file = await BackupService(database: db).createBackup();
                      RaagaSnackBar.show(
                        context: context,
                        message: 'Backup exported: ${p.basename(file.path)}',
                      );
                      _loadBackupsList();
                    },
                    child: const Text('Create Local Backup'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'AVAILABLE BACKUPS',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          if (_availableBackups.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: Text('No backup files found (.raaga_backup)'),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _availableBackups.length,
              itemBuilder: (context, index) {
                final file = _availableBackups[index];
                return ListTile(
                  leading: const Icon(Icons.settings_backup_restore_rounded),
                  title: Text(p.basename(file.path)),
                  subtitle: Text(_formatDate(file.lastModifiedSync())),
                  trailing: IconButton(
                    icon: const Icon(Icons.restore_rounded),
                    onPressed: () async {
                      final success = await RestoreService(database: db).restoreBackup(file.path);
                      if (success) {
                        RaagaSnackBar.show(context: context, message: 'Restore completed successfully.');
                        ref.invalidate(homeSongsProvider);
                      } else {
                        RaagaSnackBar.show(context: context, message: 'Restore failed.', isError: true);
                      }
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}';
  }
}
