part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnLoadTvSeriesWatchlist extends TvSeriesWatchlistEvent {
  final int id;

  OnLoadTvSeriesWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddTvSeriesWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  OnAddTvSeriesWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class OnRemoveTvSeriesWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  OnRemoveTvSeriesWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
