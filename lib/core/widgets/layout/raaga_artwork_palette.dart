import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/palette_service.dart';
import 'raaga_artwork.dart';

class RaagaArtworkPalette extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final double? radius;
  final String heroTag;
  final ValueChanged<ArtworkPalette>? onPaletteExtracted;

  const RaagaArtworkPalette({
    super.key,
    required this.imageUrl,
    this.size = 120.0,
    this.radius,
    this.heroTag = '',
    this.onPaletteExtracted,
  });

  @override
  State<RaagaArtworkPalette> createState() => _RaagaArtworkPaletteState();
}

class _RaagaArtworkPaletteState extends State<RaagaArtworkPalette> {
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(covariant RaagaArtworkPalette oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _loadImage();
    }
  }

  void _loadImage() {
    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) {
      setState(() => _imageProvider = null);
      return;
    }

    final provider = widget.imageUrl!.startsWith('http')
        ? NetworkImage(widget.imageUrl!)
        : FileImage(File(widget.imageUrl!)) as ImageProvider;

    setState(() => _imageProvider = provider);

    if (widget.onPaletteExtracted != null) {
      PaletteService.extractPalette(provider).then((palette) {
        if (mounted) widget.onPaletteExtracted!(palette);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaagaArtwork(
      imageUrl: widget.imageUrl,
      size: widget.size,
      radius: widget.radius,
      heroTag: widget.heroTag,
    );
  }
}
