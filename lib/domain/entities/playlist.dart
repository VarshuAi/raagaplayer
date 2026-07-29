import 'song.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String artworkUrl;
  final List<Song> songs;
  final String creator;

  const Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.artworkUrl,
    required this.songs,
    required this.creator,
  });
}
