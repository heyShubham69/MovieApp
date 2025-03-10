part of 'movies_list_bloc.dart';

abstract class MoviesListEvent extends Equatable {
  const MoviesListEvent();
}

class GetMovieList extends MoviesListEvent {
  @override
  List<Object> get props => [];
}