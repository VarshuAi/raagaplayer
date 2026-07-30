import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/palette_service.dart';

final artworkPaletteProvider = StateProvider<ArtworkPalette>((ref) {
  return ArtworkPalette.fallback();
});
