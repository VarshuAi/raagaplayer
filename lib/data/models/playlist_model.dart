import '../../domain/entities/playlist.dart';
import 'song_model.dart';

class PlaylistModel extends Playlist {
  const PlaylistModel({
    required super.id,
    required super.name,
    required super.description,
    required super.artworkUrl,
    required super.songs,
    required super.creator,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    final songList = (json['songs'] as List<dynamic>?)
            ?.map((e) => SongModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return PlaylistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      artworkUrl: json['artwork_url'] as String,
      songs: songList,
      creator: json['creator'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'artwork_url': artworkUrl,
      'songs': songs.map((e) => (e as SongModel).toJson()).toList(),
      'creator': creator,
    };
  }
}
