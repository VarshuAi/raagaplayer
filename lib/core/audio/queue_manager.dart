import 'dart:async';
import '../services/playback_restore.dart';
import '../../../domain/entities/song.dart';
import 'audio_queue.dart';

class QueueManager {
  static final QueueManager _instance = QueueManager._internal();
  factory QueueManager() => _instance;
  QueueManager._internal();

  final AudioQueue _queue = AudioQueue(items: []);
  final _queueChangedController = StreamController<AudioQueue>.broadcast();
  PlaybackRestoreService? _restoreService;

  Stream<AudioQueue> get onQueueChanged => _queueChangedController.stream;
  AudioQueue get currentQueue => _queue;

  void setRestoreService(PlaybackRestoreService service) {
    _restoreService = service;
  }

  String _normalizeSongKey(Song song) {
    if (song.id.isNotEmpty && song.id != '0') {
      return 'id_${song.id.trim()}';
    }
    final cleanTitle = song.title
        .replaceAll(RegExp(r'\(.*?\)'), '')
        .replaceAll(RegExp(r'\[.*?\]'), '')
        .replaceAll(RegExp(r'8D|Audio|Song|Remix|Lyrical|Official Video', caseSensitive: false), '')
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toLowerCase()
        .trim();

    final cleanArtist = song.artist.split(',')[0]
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toLowerCase()
        .trim();

    return 'meta_${cleanTitle}_$cleanArtist';
  }

  List<Song> _deduplicate(List<Song> songs) {
    final seen = <String>{};
    final result = <Song>[];
    for (final song in songs) {
      final key = _normalizeSongKey(song);
      if (!seen.contains(key)) {
        seen.add(key);
        result.add(song);
      }
    }
    return result;
  }

  void setQueue(List<Song> songs, {int initialIndex = 0}) {
    final deduped = _deduplicate(songs);
    _queue.items.clear();
    _queue.items.addAll(deduped);
    _queue.currentIndex = initialIndex.clamp(0, deduped.isEmpty ? 0 : deduped.length - 1);
    _notify();
  }

  void jumpTo(int index) {
    if (index >= 0 && index < _queue.items.length) {
      _queue.currentIndex = index;
      _notify();
    }
  }

  void add(Song song) {
    final key = _normalizeSongKey(song);
    final exists = _queue.items.any((s) => _normalizeSongKey(s) == key);
    if (!exists) {
      _queue.add(song);
      _notify();
    }
  }

  void addAll(List<Song> songs) {
    final combined = [..._queue.items, ...songs];
    final deduped = _deduplicate(combined);
    _queue.items.clear();
    _queue.items.addAll(deduped);
    _notify();
  }

  void insertNext(Song song) {
    final key = _normalizeSongKey(song);
    final exists = _queue.items.any((s) => _normalizeSongKey(s) == key);
    if (!exists) {
      if (_queue.items.isEmpty) {
        _queue.add(song);
      } else {
        _queue.items.insert(_queue.currentIndex + 1, song);
      }
      _notify();
    }
  }

  void remove(int index) {
    _queue.removeAt(index);
    _notify();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _queue.items.removeAt(oldIndex);
    _queue.items.insert(newIndex, item);
    
    // Maintain current index alignment
    if (_queue.currentIndex == oldIndex) {
      _queue.currentIndex = newIndex;
    } else if (oldIndex < _queue.currentIndex && newIndex >= _queue.currentIndex) {
      _queue.currentIndex--;
    } else if (oldIndex > _queue.currentIndex && newIndex <= _queue.currentIndex) {
      _queue.currentIndex++;
    }
    _notify();
  }

  Song? next() {
    if (_queue.hasNext) {
      _queue.next();
      _notify();
      return _queue.currentSong;
    }
    return null;
  }

  Song? previous() {
    if (_queue.hasPrevious) {
      _queue.previous();
      _notify();
      return _queue.currentSong;
    }
    return null;
  }

  void shuffle() {
    _queue.shuffle();
    _notify();
  }

  void smartShuffle(List<String> recentlyPlayedIds) {
    if (_queue.items.isEmpty) return;

    final current = _queue.currentSong;
    final candidates = List<Song>.from(_queue.items);
    if (current != null) {
      candidates.remove(current);
    }

    final recentlyPlayedSet = recentlyPlayedIds.toSet();
    final freshCandidates = candidates.where((s) => !recentlyPlayedSet.contains(s.id)).toList();
    final genericCandidates = candidates.where((s) => recentlyPlayedSet.contains(s.id)).toList();

    freshCandidates.shuffle();
    genericCandidates.shuffle();

    final orderedCandidates = [...freshCandidates, ...genericCandidates];
    final result = <Song>[];

    if (current != null) {
      result.add(current);
    }

    while (orderedCandidates.isNotEmpty) {
      final lastArtist = result.isEmpty ? "" : result.last.artist.trim().toLowerCase();
      
      int matchIndex = -1;
      for (int i = 0; i < orderedCandidates.length; i++) {
        if (orderedCandidates[i].artist.trim().toLowerCase() != lastArtist) {
          matchIndex = i;
          break;
        }
      }

      if (matchIndex != -1) {
        result.add(orderedCandidates.removeAt(matchIndex));
      } else {
        result.add(orderedCandidates.removeAt(0));
      }
    }

    _queue.items.clear();
    _queue.items.addAll(result);
    if (current != null) {
      _queue.currentIndex = _queue.items.indexOf(current);
    }
    _notify();
  }

  void clear() {
    _queue.clear();
    _notify();
  }

  void _notify() {
    _queueChangedController.add(_queue);
    _restoreService?.saveQueue(_queue.items);
  }

  void dispose() {
    _queueChangedController.close();
  }
}
