import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = "/popular-tv";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Tv Series"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularInitial || state is TvSeriesPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesPopularLoaded) {
              return ListView.builder(
                itemCount: state.popularTvSeries.length,
                itemBuilder: (context, index) {
                  final tvSeries = state.popularTvSeries[index];
                  return CardThumbnail(
                    ContentCategory.TvSeries,
                    tvSeries.id,
                    tvSeries.posterPath,
                    tvSeries.name,
                    tvSeries.overview,
                  );
                },
              );
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
      ),
    );
  }
}
