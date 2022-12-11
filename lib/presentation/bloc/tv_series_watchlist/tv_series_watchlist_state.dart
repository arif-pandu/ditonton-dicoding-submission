part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {}

class TvSeriesWatchlistStatus extends TvSeriesWatchlistState {
  final bool status;

  TvSeriesWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}

class TvSeriesWatchlistAddSuccess extends TvSeriesWatchlistState {
  final String message;

  TvSeriesWatchlistAddSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistAddFailed extends TvSeriesWatchlistState {
  final String message;

  TvSeriesWatchlistAddFailed(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistRemoveSuccess extends TvSeriesWatchlistState {
  final String message;

  TvSeriesWatchlistRemoveSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistRemoveFailed extends TvSeriesWatchlistState {
  final String message;

  TvSeriesWatchlistRemoveFailed(this.message);

  @override
  List<Object> get props => [message];
}
