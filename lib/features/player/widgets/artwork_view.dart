import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../provider/artwork_provider.dart';

class PlayerArtworkView extends ConsumerWidget {
  final String? imageUrl;
  final String heroTag;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const PlayerArtworkView({
    super.key,
    required this.imageUrl,
    this.heroTag = 'player_artwork_hero',
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(artworkPaletteProvider);
    final size = MediaQuery.of(context).size.width * 0.75;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < 0) {
          // Swipe Left = Next song (like Spotify layout)
          HapticFeedback.mediumImpact();
          onSwipeLeft();
        } else if (details.primaryVelocity! > 0) {
          // Swipe Right = Previous song
          HapticFeedback.mediumImpact();
          onSwipeRight();
        }
      },
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            boxShadow: [
              BoxShadow(
                color: palette.vibrantColor.withOpacity(0.35),
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: RaagaArtwork(
            imageUrl: imageUrl,
            size: size,
            radius: 28.0,
            heroTag: heroTag,
          ),
        ),
      ),
    );
  }
}
