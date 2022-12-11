part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationEvent extends Equatable {
  const TvSeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvSeriesRecommendation extends TvSeriesRecommendationEvent {
  final int id;

  OnFetchTvSeriesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
