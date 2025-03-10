import 'package:movie_listing/models/movieDetails.dart';
import 'package:movie_listing/models/moviesListModel.dart';
import 'package:movie_listing/models/hive/movies_model.dart';

import 'api_provider.dart';

class ApiRepository{
  final _provider = ApiProvider();

  Future<List<Movies>> fetchMovieList(){
    return _provider.fetchDataList();
  }
  Future<MovieDetails> fetchItemDetail(int postId){
    return _provider.fetchDetail(postId);
  }
}

class NetworkError extends Error {}