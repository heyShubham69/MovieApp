import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_listing/Screens/widgets/CommonWidgets.dart';
import 'package:movie_listing/models/movieDetails.dart';
import 'package:movie_listing/models/moviesListModel.dart';
import 'package:movie_listing/models/hive/movies_model.dart';
import 'package:movie_listing/utils/app_config.dart';

import '../blocs/movies_list_bloc.dart';
import 'detail_screen.dart';

class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({super.key});

  @override
  State<AllMoviesScreen> createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  final MoviesListBloc _profileBloc = MoviesListBloc();

  @override
  void initState() {
    _profileBloc.add(GetMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Movies"),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Comment Icon',
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.format_align_left),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),
      ),
      body: _buildProfileList(),
    );
  }

  Widget _buildProfileList() {
    return Container(
      color: Colors.red,
      child: BlocProvider(
        create: (_) => _profileBloc,
        child: BlocListener<MoviesListBloc, MoviesListState>(
          listener: (context, state) {
            if (state is MovieListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MoviesListBloc, MoviesListState>(
            builder: (context, state) {
              if (state is MovieListInitial) {
                return _buildLoading();
              } else if (state is MovieListLoading) {
                return _buildLoading();
              } else if (state is MovieListLoaded) {
                return _buildCard(context, state.itemModel);
              } else if (state is MovieListError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<Movies> model) {
    return ListView.builder(
      itemCount: (model.length / 2).ceil(),
      itemBuilder: (context, index) {
        int firstIndex = index * 2;
        int secondIndex = firstIndex + 1;
        return Row(
          children: [
            Expanded(child: _buildItem(model[firstIndex])),
            Expanded(
              child: secondIndex < model.length
                  ? _buildItem(model[secondIndex])
                  : Container(),
            )
          ],
        );
      },
    );
  }

  Widget _buildItem(Movies item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Card corner radius
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(postId: item.id ?? 0),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.imageCard("${AppConfig.imageUrl}${item.posterPath}"),
            _buildText(item),
          ],
        ),
      ),
    );
  }

  Widget _buildText(Movies item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber[700], // Adjust color as needed
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Movie Title & Genre
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidgets.truncatedText(item.title ?? "Title not found",
                fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),
                SizedBox(height: 4),
                  _genreView(item.genresList)
              ],
            ),
          ),
          // Favorite Icon
          IconButton(
            icon: Icon(
              true ? Icons.favorite : Icons.favorite_border,
              color: false ? Colors.red : Colors.black54,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _genreView(List<Genres>? genres) {
    String? genreText = genres?.map((g) => g.name).join(", ");
    return CommonWidgets.truncatedText(
      genreText!,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
    );
  }


  Widget _buildLoading() => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(color: Colors.white,),
        SizedBox(height: 10), // Spacing between loader and text
        Text(
          "Fetching data...",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
        ),
      ],
    ),
  );

}
