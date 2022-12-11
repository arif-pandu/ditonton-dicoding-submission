import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/detail_page/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = "/detail-tv";

  final int id;
  const TvSeriesDetailPage({required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(OnFetchTvSeriesDetail(widget.id));
      context.read<TvSeriesWatchlistBloc>().add(OnLoadTvSeriesWatchlist(widget.id));
      context.read<TvSeriesRecommendationBloc>().add(OnFetchTvSeriesRecommendation(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailInitial || state is TvSeriesDetailFetchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailFetchSuccess) {
            final tvSeries = state.tvSeries;

            return SafeArea(
              child: BlocBuilder<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
                buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                builder: (context, states) {
                  if (states is TvSeriesWatchlistStatus) {
                    return _buildDetailContent(tvSeries, states.status, context);
                  } else if (states is TvSeriesWatchlistAddSuccess) {
                    return _buildDetailContent(tvSeries, true, context);
                  } else if (states is TvSeriesWatchlistAddFailed) {
                    return _buildDetailContent(tvSeries, false, context);
                  } else if (states is TvSeriesWatchlistRemoveSuccess) {
                    return _buildDetailContent(tvSeries, false, context);
                  } else if (states is TvSeriesWatchlistRemoveFailed) {
                    return _buildDetailContent(tvSeries, true, context);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          } else if (state is TvSeriesDetailFetchFailed) {
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
    );
  }

  DetailContent _buildDetailContent(
    TvSeriesDetail tvSeries,
    bool isAddedToWatchlist,
    BuildContext context,
  ) {
    return DetailContent(
      contentCategory: ContentCategory.TvSeries,
      id: tvSeries.id,
      name: tvSeries.name,
      imageUrl: "https://image.tmdb.org/t/p/w500${tvSeries.posterPath}",
      isAddedToWatchlist: isAddedToWatchlist,
      onTapWatchlist: () {
        if (isAddedToWatchlist) {
          context.read<TvSeriesWatchlistBloc>().add(OnRemoveTvSeriesWatchlist(tvSeries));
        } else {
          context.read<TvSeriesWatchlistBloc>().add(OnAddTvSeriesWatchlist(tvSeries));
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isAddedToWatchlist ? "Removed From Watchlist" : "Added To Watchlist"),
          ),
        );
      },
      genres: tvSeries.genres,
      overview: tvSeries.overview,
      voteAverage: tvSeries.voteAverage,
      numOfSeasons: tvSeries.numberOfSeasons,
      numOfEps: tvSeries.numberOfEpisodes,
      seasonList: tvSeries.seasons,
    );
  }
}
