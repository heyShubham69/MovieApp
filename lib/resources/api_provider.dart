import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:movie_listing/models/movieDetails.dart';
import 'package:movie_listing/resources/box_hive.dart';
import 'package:movie_listing/utils/app_config.dart';
import '../models/moviesListModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/hive/movies_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl = AppConfig.baseUrl;

  ApiProvider() {
    _dio.options.headers = {
      'Accept': AppConfig.accept,
      'Authorization': AppConfig.bearerToken,
    };
  }

  final _movieBox = BoxHive.getMoviesLocally();
  final _moviedetail = BoxHive.getMovieDetailLocally();


  final Map<int, Genres> _genreCache = {};

  Future<List<Movies>> fetchDataList() async {
    try {
      // Check internet connection
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isOffline = connectivityResult == ConnectivityResult.none;

      // If offline and cache exists, return cached data
      if (isOffline && _movieBox.isNotEmpty) {
        print("Using cached movie list due to no internet.");
        return _movieBox.values.toList();
      }
      Response response = await _dio.get("$_baseUrl/${AppConfig.allMovies}");

      if (response.statusCode == 200) {
        MoviesListModel moviesList = MoviesListModel.fromJson(response.data);

        if (moviesList.results != null) {
          for (var result in moviesList.results!) {
            if (result.genreIds != null) {
              // Fetch genre details for each Genre object inside genreIds list
              List<Future<Genres>> genreFutures = result.genreIds!
                  .map((genre) => getGenreName(genre.id ?? 0))
                  .toList();
              // Wait for all genre fetch calls to complete
              List<Genres> updatedGenres = await Future.wait(genreFutures);

              // Map fetched genre names to result
              result.genreIds = updatedGenres;
            }
          }
        }
        List<Movies>? movies = (moviesList.results??[])
            .map((result) => Movies(
                  id: result.id ?? 0,
                  title: result.title ?? 'Unknown',
                  posterPath: result.posterPath ?? '',
                  genresList: result.genreIds ?? [],
                ))
            .toList();

        // Store movies in Hive for offline use
        _movieBox.clear();
        _movieBox.addAll(movies);

        return movies;
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      if (_movieBox.isNotEmpty) {
        return _movieBox.values.toList(); // Return cache on failure
      }
      throw Exception('Failed to connect to the server');
    }
  }

  Future<MovieDetails> fetchDetail(int postId) async {
    try {
      // Check internet connection
      var connectivityResult = await Connectivity().checkConnectivity();
      bool isOffline = connectivityResult == ConnectivityResult.none;

      if (isOffline && _moviedetail.isNotEmpty) {
        print("Using cached movie list due to no internet.");
        // return _moviedetail.values.toList();
      }
      Response response =
          await _dio.get("$_baseUrl${AppConfig.movieDetails}/$postId");

      if (response.statusCode == 200) {

        return MovieDetails.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieDetails.withError("Data not found / Connection issue");
    }
  }

// Function to fetch genre with caching mechanism
  Future<Genres> getGenreName(int genreId) async {
    if (_genreCache.containsKey(genreId)) {
      // Return cached genre if already fetched
      return _genreCache[genreId]!;
    }

    // Fetch genre from API if not in cache
    Genres genre = await fetchGenreName(genreId);

    // Store in cache
    _genreCache[genreId] = genre;
    return genre;
  }

  Future<Genres> fetchGenreName(int genreId) async {
    try {
      Response response =
          await _dio.get("$_baseUrl${AppConfig.genreName}/$genreId");
      return Genres.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Genres.withError("Genre not found / Connection issue");
    }
  }

  Future<bool> markAsFavorite(
      int movieId, bool isFavorite, String sessionId) async {
    try {
      Response response = await _dio.post(
        "$_baseUrl${AppConfig.markFavorite}",
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "favorite": isFavorite
        },
        queryParameters: {
          "session_id": sessionId,
        },
      );

      if (response.statusCode == 200) {
        return true; // Successfully marked as favorite
      } else {
        return false; // Failed to mark as favorite
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return false; // Handle the failure case
    }
  }
}
