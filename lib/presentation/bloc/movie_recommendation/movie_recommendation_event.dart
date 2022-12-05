part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  OnFetchMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
