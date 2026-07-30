import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/song.dart';

final currentSongProvider = StateProvider<Song?>((ref) => null);
