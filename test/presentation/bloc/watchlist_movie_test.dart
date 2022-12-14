import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  group(
    "get list of Movie watchlist",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(watchlistMovieBloc.state, WatchlistMovieInitial());
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        "should emit [Loading, MovieLoaded] when data gotten successfully",
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => Right(testMovieList),
          );
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieLoaded(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        "should emit [Loading, MovieError] when data is not loaded successfully",
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => Left(DatabaseFailure("Failed")),
          );
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
    },
  );
}
