part of 'movies_list_bloc.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object?> get props => [];
}

class MovieListInitial extends MoviesListState {}

class MovieListLoading extends MoviesListState {}

class MovieListLoaded extends MoviesListState {
  final List<Movies> itemModel;
  const MovieListLoaded(this.itemModel);
  @override
  List<Object?> get props => [itemModel];
}

class MovieListError extends MoviesListState {
  final String? message;
  const MovieListError(this.message);
}