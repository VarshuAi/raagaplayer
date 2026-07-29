import 'package:flutter/material.dart';
import '../../../domain/entities/song.dart';
import '../../design_tokens/spacing.dart';
import '../../design_tokens/icon_size.dart';
import '../../extensions/context_extensions.dart';
import '../layout/raaga_artwork.dart';
import '../layout/animation_presets.dart';

class RaagaSongTile extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback? onMoreTap;

  const RaagaSongTile({
    super.key,
    required this.song,
    this.isPlaying = false,
    required this.onTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTap(
      onTap: onTap,
      child: Container(
        height: 72.0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isPlaying
              ? context.colorScheme.primary.withOpacity(0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Album Artwork with Music First style
            RaagaArtwork(
              imageUrl: song.artworkUrl,
              size: 56.0,
              radius: 12.0,
              heroTag: 'song_art_${song.id}',
            ),
            const SizedBox(width: AppSpacing.md),
            // Details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: isPlaying
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurface,
                      fontWeight:
                          isPlaying ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${song.artist} • ${song.album}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.50),
                    ),
                  ),
                ],
              ),
            ),
            // Trailing items
            if (isPlaying) ...[
              Icon(
                Icons.volume_up_rounded,
                color: context.colorScheme.primary,
                size: AppIconSize.md,
              ),
              const SizedBox(width: AppSpacing.md),
            ],
            if (onMoreTap != null)
              GestureDetector(
                onTap: onMoreTap,
                child: Icon(
                  Icons.more_vert_rounded,
                  color: context.colorScheme.onSurface.withOpacity(0.50),
                  size: AppIconSize.md,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
