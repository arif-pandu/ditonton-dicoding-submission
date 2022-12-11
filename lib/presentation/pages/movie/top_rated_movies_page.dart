import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-movie';
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Rated Movies"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
          builder: (context, state) {
            if (state is MovieTopRatedInitial || state is MovieTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieTopRatedLoaded) {
              return ListView.builder(
                itemCount: state.topRatedMovie.length,
                itemBuilder: (context, index) {
                  final movie = state.topRatedMovie[index];
                  return CardThumbnail(
                    ContentCategory.Film,
                    movie.id,
                    movie.posterPath,
                    movie.title,
                    movie.overview,
                  );
                },
              );
            } else if (state is MovieTopRatedError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text(state.runtimeType.toString()),
              );
            }
          },
        ),
      ),
    );
  }
}
