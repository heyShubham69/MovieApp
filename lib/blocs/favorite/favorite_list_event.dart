abstract class FavoriteListEvent {}

class ToggleFavoriteEvent extends FavoriteListEvent {
  final int movieId;

  ToggleFavoriteEvent(this.movieId);
}
