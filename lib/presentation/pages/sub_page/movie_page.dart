import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/widgets/list_builder_movie.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Now Playing',
          style: kHeading6,
        ),
        BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
          builder: (context, state) {
            if (state is MovieNowPlayingInitial || state is MovieNowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieNowPlayingLoaded) {
              return MovieList(state.nowPlayingMovie);
            } else if (state is MovieNowPlayingError) {
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
        SubHeading(
          title: 'Popular Movies',
          onTap: () => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
        ),
        BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            if (state is MoviePopularInitial || state is MoviePopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularLoaded) {
              return MovieList(state.popularMovie);
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
        SubHeading(
          title: 'Top Rated Movies',
          onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
        ),
        Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.topRatedMoviesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return MovieList(data.topRatedMovies);
          } else {
            return Text('Failed');
          }
        }),
      ],
    );
  }
}
