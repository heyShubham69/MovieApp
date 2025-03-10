part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}
class ProfileInitial extends PostState {}
class PostDetailsLoading extends PostState {}

class PostDetailsLoaded extends PostState {
  final MovieDetails post;

  const PostDetailsLoaded(this.post);

  get itemModel => post;
}

class PostDetailsError extends PostState {
  final String message;

  const PostDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
