import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = "/top-rated-tv";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Rated Tv Series"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedInitial || state is TvSeriesTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesTopRatedLoaded) {
              return ListView.builder(
                itemCount: state.topRatedTvSeries.length,
                itemBuilder: (context, index) {
                  final tvSeries = state.topRatedTvSeries[index];
                  return CardThumbnail(
                    ContentCategory.TvSeries,
                    tvSeries.id,
                    tvSeries.posterPath,
                    tvSeries.name,
                    tvSeries.overview,
                  );
                },
              );
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
      ),
    );
  }
}
