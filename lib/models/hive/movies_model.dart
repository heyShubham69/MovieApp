import 'package:hive/hive.dart';
import 'package:movie_listing/models/movieDetails.dart';

part 'movies_model.g.dart'; // This will be auto-generated

@HiveType(typeId: 0) // Assign a unique type ID
class Movies extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final List<Genres> genresList;

  Movies({required this.id, required this.title, required this.posterPath, required this.genresList});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      genresList: json['genre_ids'] != null
          ? (json['genre_ids'] as List).map((id) => Genres.fromJson(id)).toList()
        : []
    );
  }
}
