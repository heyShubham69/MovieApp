import 'package:hive/hive.dart';
import 'package:movie_listing/models/hive/detail_screen_model.dart';
import 'package:movie_listing/models/hive/movies_model.dart';


class BoxHive{
static Box<Movies> getMoviesLocally() => Hive.box<Movies>('allMovies');
static Box<DetailScreenModel> getMovieDetailLocally() => Hive.box<DetailScreenModel>("detailScreenBox");
}