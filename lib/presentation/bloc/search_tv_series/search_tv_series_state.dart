part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState {}

class SearchTvSeriesLoading extends SearchTvSeriesState {}

class SearchTvSeriesHasResult extends SearchTvSeriesState {
  final List<TvSeries> tvSeriesResult;

  SearchTvSeriesHasResult(this.tvSeriesResult);

  @override
  List<Object> get props => [tvSeriesResult];
}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  SearchTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
