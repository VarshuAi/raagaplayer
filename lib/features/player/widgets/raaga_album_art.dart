import 'package:flutter/material.dart';
import '../../../core/widgets/layout/raaga_artwork.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';

class RaagaPlayerAlbumArt extends StatelessWidget {
  final String? imageUrl;
  final String heroTag;

  const RaagaPlayerAlbumArt({
    super.key,
    required this.imageUrl,
    this.heroTag = 'player_album_art',
  });

  @override
  Widget build(BuildContext context) {
    final double artSize = context.screenWidth * 0.8;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Center(
        child: RaagaArtwork(
          imageUrl: imageUrl,
          size: artSize,
          showGlow: true,
          heroTag: heroTag,
        ),
      ),
    );
  }
}
