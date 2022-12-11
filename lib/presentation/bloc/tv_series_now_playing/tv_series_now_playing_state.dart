part of 'tv_series_now_playing_bloc.dart';

abstract class TvSeriesNowPlayingState extends Equatable {
  const TvSeriesNowPlayingState();

  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingInitial extends TvSeriesNowPlayingState {}

class TvSeriesNowPlayingLoading extends TvSeriesNowPlayingState {}

class TvSeriesNowPlayingLoaded extends TvSeriesNowPlayingState {
  final List<TvSeries> nowPlayingTvSeries;

  TvSeriesNowPlayingLoaded(this.nowPlayingTvSeries);

  @override
  List<Object> get props => [nowPlayingTvSeries];
}

class TvSeriesNowPlayingError extends TvSeriesNowPlayingState {
  final String message;

  TvSeriesNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
