import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/list_builder_tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TvSeriesPage extends StatelessWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        onTap: () => Navigator.pushNamed(context, PopularTVSeriesPage.ROUTE_NAME),
      ),
      Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
        final state = data.populartvSeriesState;
        if (state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.Loaded) {
          return TvSeriesList(data.popularTvSeries);
        } else {
          return Text('Failed');
        }
      }),
      SubHeading(
        title: 'Top Rated Tv Series',
        onTap: () => Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
      ),
      Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
        final state = data.topRatedTvSeriesState;
        if (state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.Loaded) {
          return TvSeriesList(data.topRatedTvSeries);
        } else {
          return Text('Failed');
        }
      }),
    ]);
  }
}
