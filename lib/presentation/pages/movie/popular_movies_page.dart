import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-movie';
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            if (state is MoviePopularInitial || state is MoviePopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularLoaded) {
              return ListView.builder(
                itemCount: state.popularMovie.length,
                itemBuilder: (context, index) {
                  final movie = state.popularMovie[index];
                  return CardThumbnail(
                    ContentCategory.Film,
                    movie.id,
                    movie.posterPath,
                    movie.title,
                    movie.overview,
                  );
                },
              );
            } else if (state is MoviePopularError) {
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
