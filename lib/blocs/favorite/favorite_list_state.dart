abstract class FavoriteListState {}

class FavoriteUpdatedState extends FavoriteListState {
  final Map<int, bool> favoriteMovies;

  FavoriteUpdatedState(this.favoriteMovies);
}
