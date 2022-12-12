import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/list_builder_tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesPage extends StatelessWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubHeading(
          title: "Airing Today",
          onTap: () => Navigator.pushNamed(context, NowPlayingTvSeriesPage.ROUTE_NAME),
        ),
        BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
          builder: (context, state) {
            if (state is TvSeriesNowPlayingInitial || state is TvSeriesNowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesNowPlayingLoaded) {
              return TvSeriesList(state.nowPlayingTvSeries);
            } else if (state is TvSeriesNowPlayingError) {
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
          title: 'Popular Tv Series',
          onTap: () => Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
        ),
        BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularInitial || state is TvSeriesPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesPopularLoaded) {
              return TvSeriesList(state.popularTvSeries);
            } else if (state is TvSeriesPopularError) {
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
          title: 'Top Rated Tv Series',
          onTap: () => Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
        ),
        BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedInitial || state is TvSeriesTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesTopRatedLoaded) {
              return TvSeriesList(state.topRatedTvSeries);
            } else if (state is TvSeriesTopRatedError) {
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
      ],
    );
  }
}
