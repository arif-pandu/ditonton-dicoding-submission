part of 'tv_series_now_playing_bloc.dart';

abstract class TvSeriesNowPlayingEvent extends Equatable {
  const TvSeriesNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvSeriesNowPlaying extends TvSeriesNowPlayingEvent {}
