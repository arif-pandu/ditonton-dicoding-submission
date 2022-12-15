import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  group(
    "get top rated Movie",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(movieTopRatedBloc.state, MovieTopRatedInitial());
        },
      );

      blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        "should emit [Loading, Loaded] when data is gotten successfully",
        build: () {
          when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => Right(testMovieList),
          );
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieTopRated()),
        expect: () => [
          MovieTopRatedLoading(),
          MovieTopRatedLoaded(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );

      blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        "should emit [Loading, Error] when data is failed to get",
        build: () {
          when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieTopRated()),
        expect: () => [
          MovieTopRatedLoading(),
          MovieTopRatedError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
    },
  );
}
