import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_listing/models/movieDetails.dart';

import '../../resources/api_repository.dart';


part 'post_state.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostDetailsLoading()) {
    final ApiRepository apiRepository = ApiRepository();

    on<FetchPostDetails>((event, emit) async {
      try {
        emit(PostDetailsLoading());
        final mList = await apiRepository.fetchItemDetail(event.postId);
        emit(PostDetailsLoaded(mList));
      }
      on NetworkError {
        emit(
            PostDetailsError("Failed to fetch data. is your device online?"));
      } catch (e) {
        emit(PostDetailsError(e.toString()));
      }
    });
  }
}
