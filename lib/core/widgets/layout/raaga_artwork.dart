import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../extensions/context_extensions.dart';
import '../../config/app_assets.dart';

class RaagaArtwork extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double? radius;
  final String heroTag;
  final List<BoxShadow>? shadows;
  final bool showGlow;

  const RaagaArtwork({
    super.key,
    required this.imageUrl,
    this.size = 120.0,
    this.radius,
    this.heroTag = '',
    this.shadows,
    this.showGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = radius ?? AppRadius.albumArt;
    
    Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: Container(
        width: size,
        height: size,
        color: context.colorScheme.surfaceContainerHigh,
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildLoading();
                },
              )
            : _buildPlaceholder(),
      ),
    );

    // Apply Hero animation wrapper
    if (heroTag.isNotEmpty) {
      imageWidget = Hero(
        tag: heroTag,
        flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
          return Material(
            color: Colors.transparent,
            child: toHeroContext.widget,
          );
        },
        child: imageWidget,
      );
    }

    // Apply ambient visual glow shadow list if requested
    final decorationShadows = shadows ?? (showGlow ? context.raagaTheme.albumShadow : null);
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveRadius),
        boxShadow: decorationShadows,
      ),
      child: imageWidget,
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.music_note_rounded,
        size: size * 0.4,
        color: Colors.white.withOpacity(0.3),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: SizedBox(
        width: size * 0.25,
        height: size * 0.25,
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
