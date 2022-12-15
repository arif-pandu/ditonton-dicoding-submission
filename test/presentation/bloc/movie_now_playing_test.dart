import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  group(
    "get now playing Movie",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(movieNowPlayingBloc.state, MovieNowPlayingInitial());
        },
      );

      blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        "should emit [Loading, Loaded] when data is gotten successfully",
        build: () {
          when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => Right(testMovieList),
          );
          return movieNowPlayingBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieNowPlaying()),
        expect: () => [
          MovieNowPlayingLoading(),
          MovieNowPlayingLoaded(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );

      blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        "should emit [Loading, Error] when data is failed to get",
        build: () {
          when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return movieNowPlayingBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieNowPlaying()),
        expect: () => [MovieNowPlayingLoading(), MovieNowPlayingError("Failed")],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );
    },
  );
}
