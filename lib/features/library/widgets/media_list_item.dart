import 'package:flutter/material.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../../../core/widgets/layout/animation_presets.dart';

class MediaListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? artworkUrl;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Widget? trailing;
  final String heroTag;

  const MediaListItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.artworkUrl,
    required this.onTap,
    required this.onLongPress,
    this.trailing,
    this.heroTag = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: AnimatedTap(
        onTap: onTap,
        child: Container(
        height: 72.0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            RaagaArtwork(
              imageUrl: artworkUrl,
              size: 56.0,
              radius: 12.0,
              heroTag: heroTag,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.50),
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
      ),
    );
  }
}
