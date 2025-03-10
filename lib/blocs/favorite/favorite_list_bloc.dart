import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_listing/blocs/favorite/favorite_list_event.dart';
import 'package:movie_listing/blocs/favorite/favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  Map<int, bool> favoriteMovies = {};

  FavoriteListBloc() : super(FavoriteUpdatedState({})) {
    on<ToggleFavoriteEvent>((event, emit) {
      favoriteMovies[event.movieId] = !(favoriteMovies[event.movieId] ?? false);
      emit(FavoriteUpdatedState(Map.from(favoriteMovies)));
    });
  }
}
