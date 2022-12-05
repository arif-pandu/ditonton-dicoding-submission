import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  MovieRecommendationBloc(
    this.getMovieRecommendations,
  ) : super(MovieRecommendationInitial()) {
    on<OnFetchMovieRecommendation>(_onFetchMovieRecommendation);
  }

  final GetMovieRecommendations getMovieRecommendations;

  void _onFetchMovieRecommendation(
    OnFetchMovieRecommendation event,
    Emitter<MovieRecommendationState> emit,
  ) async {
    print("EMIT LOADING");
    emit(MovieRecommendationLoading());

    final result = await getMovieRecommendations.execute(event.id);

    await result.fold(
      (failure) async {
        print("EMIT FAILED");
        emit(MovieRecommendationError(failure.message));
      },
      (recommendation) async {
        print("EMIT SUCCESS");
        emit(MovieRecommendationLoaded(recommendation));
      },
    );
  }
}
