part of 'tv_series_top_rated_bloc.dart';

abstract class TvSeriesTopRatedEvent extends Equatable {
  const TvSeriesTopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvSeriesTopRated extends TvSeriesTopRatedEvent {}
