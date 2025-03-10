import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get accept => dotenv.env['ACCEPT'] ?? '';

  static String get bearerToken => dotenv.env['BEARER_TOKEN'] ?? '';

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  static String get imageUrl => dotenv.env['IMAGE_URL'] ?? '';

  static String get allMovies => dotenv.env['ALL_MOVIES_ENDPOINT'] ?? '';

  static String get movieDetails => dotenv.env['MOVIE_DETAILS'] ?? '';

  static String get genreName => dotenv.env['GENRE_NAME'] ?? '';

  static String get markFavorite => dotenv.env['FAVORITE'] ?? '';
}
