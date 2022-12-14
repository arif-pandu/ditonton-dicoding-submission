import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  final tId = 1;

  group(
    "get movie watchlist status",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(movieWatchlistBloc.state, MovieWatchlistInitial());
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "should emit [Status] after onLoad ",
        build: () {
          when(mockGetWatchListStatus.executeMovie(tId)).thenAnswer(
            (_) async => false,
          );
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnLoadMovieWatchlist(tId)),
        expect: () => [
          MovieWatchlistStatus(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.executeMovie(tId));
        },
      );
    },
  );

  group(
    "add Movie into watchlist",
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "should emit [AddSuccess] when success add Movie into watchlist",
        build: () {
          when(mockSaveWatchlist.executeMovie(testMovieDetail)).thenAnswer(
            (_) async => Right("Success"),
          );
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnAddMovieWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistAddSuccess("Success"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.executeMovie(testMovieDetail));
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "should emit [AddFailed] when failed to add Movie into watchlist",
        build: () {
          when(mockSaveWatchlist.executeMovie(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure("Failed")),
          );
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnAddMovieWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistAddFailed("Failed"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.executeMovie(testMovieDetail));
        },
      );
    },
  );

  group(
    "remove Movie from watchlist",
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "should emit [RemoveSuccess] when success remove Movie from watchlist",
        build: () {
          when(mockRemoveWatchlist.executeMovie(testMovieDetail)).thenAnswer(
            (_) async => Right("Success"),
          );
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnRemoveMovieWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistRemoveSuccess("Success"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.executeMovie(testMovieDetail));
        },
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "should emit [RemoveFailed] when unable to remove Movie from watchlist",
        build: () {
          when(mockRemoveWatchlist.executeMovie(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure("Failed")),
          );
          return movieWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnRemoveMovieWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistRemoveFailed("Failed"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.executeMovie(testMovieDetail));
        },
      );
    },
  );
}
