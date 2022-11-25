import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/list_builder_tv_series.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesPage extends StatelessWidget {
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Airing Today',
        style: kHeading6,
      ),
      Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
        final state = data.nowPlayingState;
        if (state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.Loaded) {
          return TvSeriesList(data.nowPlayingTvSeries);
        } else {
          return Text('Failed');
        }
      }),
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
