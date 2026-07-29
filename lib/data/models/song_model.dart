import '../../domain/entities/song.dart';

class SongModel extends Song {
  const SongModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.album,
    required super.artworkUrl,
    required super.sourceUrl,
    required super.duration,
    super.isLocal,
    super.isFavorite,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      artworkUrl: json['artwork_url'] as String,
      sourceUrl: json['source_url'] as String,
      duration: Duration(seconds: json['duration_seconds'] as int),
      isLocal: json['is_local'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'artwork_url': artworkUrl,
      'source_url': sourceUrl,
      'duration_seconds': duration.inSeconds,
      'is_local': isLocal,
      'is_favorite': isFavorite,
    };
  }
}
