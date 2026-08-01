import 'dart:io';
import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../extensions/context_extensions.dart';
import '../../config/app_assets.dart';
import '../indicators/raaga_indicators.dart';

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
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildImageWidget(context),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size > 80 ? 8 : 5,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(effectiveRadius),
                    bottomRight: const Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.music_note_rounded,
                      size: size > 80 ? 10 : 8,
                      color: context.colorScheme.primary,
                    ),
                    if (size > 70) ...[
                      const SizedBox(width: 3),
                      const Text(
                        'A1 RAAGA',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
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
      child: RaagaCircularIndicator(size: size * 0.3),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) return _buildPlaceholder();

    final url = imageUrl!;
    if (url.startsWith('/') || url.startsWith('file://') || url.contains(':\\')) {
      final cleanPath = url.replaceFirst('file://', '');
      return Image.file(
        File(cleanPath),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoading();
      },
    );
  }
}
