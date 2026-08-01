import 'song.dart';
import 'album.dart';
import 'artist.dart';
import 'playlist.dart';

class SearchResult {
  final List<Song> songs;
  final List<Album> albums;
  final List<Artist> artists;
  final List<Playlist> playlists;

  const SearchResult({
    required this.songs,
    required this.albums,
    required this.artists,
    required this.playlists,
  });

  factory SearchResult.empty() => const SearchResult(
        songs: [],
        albums: [],
        artists: [],
        playlists: [],
      );
}
