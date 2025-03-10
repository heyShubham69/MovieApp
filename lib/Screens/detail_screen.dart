import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_listing/Screens/widgets/CommonWidgets.dart';
import 'package:movie_listing/models/movieDetails.dart';
import 'package:movie_listing/resources/box_hive.dart';
import 'package:movie_listing/utils/app_config.dart';

import '../blocs/favorite/favorite_list_bloc.dart';
import '../blocs/favorite/favorite_list_event.dart';
import '../blocs/favorite/favorite_list_state.dart';
import '../blocs/item_detail/post_bloc.dart';

class DetailScreen extends StatefulWidget {
  final int postId;

  const DetailScreen({super.key, required this.postId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final PostBloc _movieDetailBloc = PostBloc();

  @override
  void initState() {
    _movieDetailBloc.add(FetchPostDetails(widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Details"),
      ),
      body: _buildPostDetails(),
    );
  }

  Widget _buildPostDetails() {
    return BlocProvider(
      create: (_) => _movieDetailBloc,
      child: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              return _buildLoading();
            } else if (state is PostDetailsLoading) {
              return _buildLoading();
            } else if (state is PostDetailsLoaded) {
              return _buildCard(context, state.itemModel);
            } else if (state is PostDetailsError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, MovieDetails model) {
   var list = BoxHive.getMoviesLocally().values.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              "${AppConfig.imageUrl}${model.backdropPath}",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return CommonWidgets.imageError(double.infinity, 250, 150);
              },
              cacheWidth: 300,
              cacheHeight: 400,
            ),
            Positioned.fill(
              child: Center(
                child:
                    Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
              ),
            ),
          ],
        ),

        // Overlapping Movie Details
        Container(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Small Overlapping Image
              Container(
                transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                // Move the box up to overlap
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "${AppConfig.imageUrl}${model.posterPath}",
                    width: 180,
                    height: 230,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 230,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return CommonWidgets.imageError(180,230,100);
                    },
                    cacheWidth: 300,
                    cacheHeight: 400,
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Movie Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model.title}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text("${model.releaseDate}",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 4),
                    Text("Average rating: ${model.voteAverage?.toStringAsFixed(1)}",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  true ? Icons.favorite : Icons.favorite_border,
                  color: false ? Colors.red : Colors.black54,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        CommonWidgets.dividerWidget(),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CommonWidgets.customText("${model.overview}",
                color: Colors.grey, fontWeight: FontWeight.bold)),
        CommonWidgets.dividerWidget(),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CommonWidgets.customText(
              "Trailers",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ))
      ],
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
