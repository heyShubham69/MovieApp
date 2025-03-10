import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_listing/models/moviesListModel.dart';
import 'package:movie_listing/models/hive/movies_model.dart';

import '../resources/api_repository.dart';

part 'movies_list_event.dart';

part 'movies_list_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  MoviesListBloc() : super(MovieListInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieListLoading());
        final mList = await apiRepository.fetchMovieList();
        emit(MovieListLoaded(mList));
      }
      on NetworkError {
        emit(
            const MovieListError("Failed to fetch data. is your device online?"));
      } catch(e){
        emit(MovieListError(e.toString()));
      }
    });
  }
}
