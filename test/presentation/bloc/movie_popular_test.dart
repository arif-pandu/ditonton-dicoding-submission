import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularBloc moviePopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  group(
    "get popular Movie",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(moviePopularBloc.state, MoviePopularInitial());
        },
      );

      blocTest<MoviePopularBloc, MoviePopularState>(
        "should emit [Loading, Loaded] when data is gotten successfully",
        build: () {
          when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => Right(testMovieList),
          );
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(OnFetchMoviePopular()),
        expect: () => [
          MoviePopularLoading(),
          MoviePopularLoaded(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );

      blocTest<MoviePopularBloc, MoviePopularState>(
        "should emit [Loading, Error] when data is failed to get",
        build: () {
          when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(OnFetchMoviePopular()),
        expect: () => [
          MoviePopularLoading(),
          MoviePopularError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );
    },
  );
}
