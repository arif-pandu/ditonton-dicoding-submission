part of 'tv_series_popular_bloc.dart';

abstract class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object> get props => [];
}

class TvSeriesPopularInitial extends TvSeriesPopularState {}

class TvSeriesPopularLoading extends TvSeriesPopularState {}

class TvSeriesPopularLoaded extends TvSeriesPopularState {
  final List<TvSeries> popularTvSeries;

  TvSeriesPopularLoaded(this.popularTvSeries);

  @override
  List<Object> get props => [popularTvSeries];
}

class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;

  TvSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}
