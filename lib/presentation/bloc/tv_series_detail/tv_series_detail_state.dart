part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TvSeriesDetailFetchLoading extends TvSeriesDetailState {}

class TvSeriesDetailFetchSuccess extends TvSeriesDetailState {
  final TvSeriesDetail tvSeries;

  TvSeriesDetailFetchSuccess(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesDetailFetchFailed extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailFetchFailed(this.message);

  @override
  List<Object> get props => [message];
}
