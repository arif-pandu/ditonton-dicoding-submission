part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {}

class TvSeriesRecommendationLoaded extends TvSeriesRecommendationState {
  final List<TvSeries> results;

  TvSeriesRecommendationLoaded(this.results);

  @override
  List<Object> get props => [results];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
