import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  TvSeriesRecommendationBloc(
    this.getTvSeriesRecommendations,
  ) : super(TvSeriesRecommendationInitial()) {
    on<OnFetchTvSeriesRecommendation>(_onFetchTvSeriesRecommendation);
  }

  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  void _onFetchTvSeriesRecommendation(
    OnFetchTvSeriesRecommendation event,
    Emitter<TvSeriesRecommendationState> emit,
  ) async {
    emit(TvSeriesRecommendationLoading());

    final result = await getTvSeriesRecommendations.execute(event.id);

    result.fold(
      (failure) {
        emit(TvSeriesRecommendationError(failure.message));
      },
      (recommendation) {
        emit(TvSeriesRecommendationLoaded(recommendation));
      },
    );
  }
}
