import 'package:hive/hive.dart';

part 'detail_screen_model.g.dart'; // Generated file

@HiveType(typeId: 2)
class DetailScreenModel {
  @HiveField(0)
  final num voteAverage;

  @HiveField(1)
  final String releaseDate;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final String backdropPath;

  @HiveField(5)
  final String overview;

  DetailScreenModel({
    required this.voteAverage,
    required this.releaseDate,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
  });

  factory DetailScreenModel.fromJson(Map<String, dynamic> json) {
    return DetailScreenModel(
      voteAverage: json["vote_average"] ?? 0.0,
      releaseDate: json["release_date"] ?? "",
      title: json["title"] ?? "Unknown",
      posterPath: json["poster_path"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      overview: json["overview"] ?? "No description available",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vote_average": voteAverage,
      "release_date": releaseDate,
      "title": title,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "overview": overview,
    };
  }
}
