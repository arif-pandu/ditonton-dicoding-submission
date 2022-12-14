import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendation_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationBloc = TvSeriesRecommendationBloc(mockGetTvSeriesRecommendations);
  });

  final tId = 1;

  group(
    "get TvSeries Recommendations",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(tvSeriesRecommendationBloc.state, TvSeriesRecommendationInitial());
        },
      );

      blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
        "should emit [Loading, RecommendationLoaded] when data is gotten successfully",
        build: () {
          when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
            (_) async => Right(testTvSeriesList),
          );
          return tvSeriesRecommendationBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesRecommendation(tId)),
        expect: () => [
          TvSeriesRecommendationLoading(),
          TvSeriesRecommendationLoaded(testTvSeriesList),
        ],
        verify: (bloc) {
          verify(mockGetTvSeriesRecommendations.execute(tId));
        },
      );

      blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
        "should emit [Loading, RecommendationError] when data is not loaded successfully",
        build: () {
          when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return tvSeriesRecommendationBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesRecommendation(tId)),
        expect: () => [
          TvSeriesRecommendationLoading(),
          TvSeriesRecommendationError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetTvSeriesRecommendations.execute(tId));
        },
      );
    },
  );
}
