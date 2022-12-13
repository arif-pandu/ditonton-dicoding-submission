import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = "/now-playing-tv";
  const NowPlayingTvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tv Series Airing Today"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
          builder: (context, state) {
            if (state is TvSeriesNowPlayingInitial || state is TvSeriesNowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesNowPlayingLoaded) {
              return ListView.builder(
                itemCount: state.nowPlayingTvSeries.length,
                itemBuilder: (context, index) {
                  final tvSeries = state.nowPlayingTvSeries[index];
                  return CardThumbnail(
                    ContentCategory.TvSeries,
                    tvSeries.id,
                    tvSeries.posterPath,
                    tvSeries.name,
                    tvSeries.overview,
                  );
                },
              );
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
      ),
    );
  }
}
