class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String artworkUrl;
  final String sourceUrl;
  final Duration duration;
  final bool isLocal;
  final bool isFavorite;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.artworkUrl,
    required this.sourceUrl,
    required this.duration,
    this.isLocal = false,
    this.isFavorite = false,
  });

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? artworkUrl,
    String? sourceUrl,
    Duration? duration,
    bool? isLocal,
    bool? isFavorite,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      duration: duration ?? this.duration,
      isLocal: isLocal ?? this.isLocal,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
