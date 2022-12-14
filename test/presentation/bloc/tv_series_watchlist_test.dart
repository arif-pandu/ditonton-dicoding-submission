import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  final tId = 1;

  group(
    "get tv series watchlist status",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(tvSeriesWatchlistBloc.state, TvSeriesWatchlistInitial());
        },
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "should emit [Status] after onLoad",
        build: () {
          when(mockGetWatchListStatus.executeTvSeries(tId)).thenAnswer(
            (_) async => false,
          );
          return tvSeriesWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnLoadTvSeriesWatchlist(tId)),
        expect: () => [
          TvSeriesWatchlistStatus(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.executeTvSeries(tId));
        },
      );
    },
  );

  group(
    "add TvSeries into watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "should emit [AddSuccess] when success add TvSeries into watchlist",
        build: () {
          when(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail)).thenAnswer(
            (_) async => Right("Success"),
          );
          return tvSeriesWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnAddTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistAddSuccess("Success"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail));
        },
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "should emit [AddFailed] when failed to add TvSeries into watchlist",
        build: () {
          when(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure("Failed")),
          );
          return tvSeriesWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnAddTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistAddFailed("Failed"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail));
        },
      );
    },
  );

  group(
    "remove Movie from watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "should emit [RemoveSuccess] when success remove TvSeries from watchlist",
        build: () {
          when(mockRemoveWatchlist.executeTvSeries(testTvSeriesDetail)).thenAnswer(
            (_) async => Right("Success"),
          );
          return tvSeriesWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnRemoveTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistRemoveSuccess("Success"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.executeTvSeries(testTvSeriesDetail));
        },
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "should emit [RemoveFailed] when unable to remove Movie from watchlist",
        build: () {
          when(mockRemoveWatchlist.executeTvSeries(testTvSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure("Failed")),
          );
          return tvSeriesWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnRemoveTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistRemoveFailed("Failed"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.executeTvSeries(testTvSeriesDetail));
        },
      );
    },
  );
}
