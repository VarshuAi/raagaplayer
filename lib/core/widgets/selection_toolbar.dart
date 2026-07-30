import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../design_tokens/spacing.dart';
import 'layout/glass_container.dart';

class SelectionToolbar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onClear;
  final VoidCallback onAddToQueue;
  final VoidCallback onAddToPlaylist;
  final VoidCallback onDelete;

  const SelectionToolbar({
    super.key,
    required this.selectedCount,
    required this.onClear,
    required this.onAddToQueue,
    required this.onAddToPlaylist,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedCount == 0) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.md),
        child: RaagaGlassContainer(
          height: 64.0,
          borderRadius: BorderRadius.circular(16.0),
          opacity: 0.14,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: onClear,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '$selectedCount Selected',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.playlist_add_rounded),
                tooltip: 'Add to Playlist',
                onPressed: onAddToPlaylist,
              ),
              IconButton(
                icon: const Icon(Icons.queue_music_rounded),
                tooltip: 'Add to Queue',
                onPressed: onAddToQueue,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                tooltip: 'Delete Selected',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
