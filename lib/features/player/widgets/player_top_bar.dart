import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../provider/player_provider.dart';

class PlayerTopBar extends ConsumerWidget implements PreferredSizeWidget {
  const PlayerTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongProvider);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: RaagaIconButton(
        icon: Icons.keyboard_arrow_down_rounded,
        onTap: () => Navigator.of(context).pop(),
      ),
      title: Column(
        children: [
          Text(
            'NOW PLAYING',
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.50),
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          if (song != null) ...[
            const SizedBox(height: 2),
            Text(
              song.album,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.38),
              ),
            ),
          ],
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            song?.isFavorite == true ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: song?.isFavorite == true ? context.colorScheme.primary : null,
          ),
          onPressed: () {
            // Toggle song Favorite state in database
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {
            // Trigger track metadata details context menu
          },
        ),
      ],
    );
  }
}
