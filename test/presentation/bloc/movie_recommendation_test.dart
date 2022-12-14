import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  final tId = 1;

  group(
    "get Movie recommendations",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(movieRecommendationBloc.state, MovieRecommendationInitial());
        },
      );

      blocTest<MovieRecommendationBloc, MovieRecommendationState>(
        "should emit [Loading, RecommendationLoaded] when data is gotten successfully",
        build: () {
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => Right(testMovieList),
          );
          return movieRecommendationBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendation(tId)),
        expect: () => [
          MovieRecommendationLoading(),
          MovieRecommendationLoaded(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        },
      );

      blocTest<MovieRecommendationBloc, MovieRecommendationState>(
        "should emit [Loading, RecommendationError] when data is not loaded successfully",
        build: () {
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return movieRecommendationBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendation(tId)),
        expect: () => [
          MovieRecommendationLoading(),
          MovieRecommendationError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        },
      );
    },
  );
}
