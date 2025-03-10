part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchPostDetails extends PostEvent {
  final int postId;

  const FetchPostDetails(this.postId);

  @override
  List<Object?> get props => [postId];
}
