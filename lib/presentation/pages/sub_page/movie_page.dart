import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_list_builder.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
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
        Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.nowPlayingState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return MovieList(data.nowPlayingMovies);
          } else {
            return Text('Failed');
          }
        }),
        SubHeading(
          title: 'Popular Movies',
          onTap: () => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
        ),
        Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.popularMoviesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return MovieList(data.popularMovies);
          } else {
            return Text('Failed');
          }
        }),
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
