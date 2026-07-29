import '../../domain/entities/artist.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    required super.id,
    required super.name,
    required super.bio,
    required super.artworkUrl,
    required super.monthlyListeners,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
      artworkUrl: json['artwork_url'] as String,
      monthlyListeners: json['monthly_listeners'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'artwork_url': artworkUrl,
      'monthly_listeners': monthlyListeners,
    };
  }
}
