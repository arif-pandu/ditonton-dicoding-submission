import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_test.mocks.dart';

@GenerateMocks([GetWathclistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWathclistTvSeries mockGetWathclistTvSeries;

  setUp(() {
    mockGetWathclistTvSeries = MockGetWathclistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWathclistTvSeries);
  });

  group(
    "get list of TvSeries watchlist",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesInitial());
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        "should emit [Loading, TvSeriesLoaded] when data gotten successfully",
        build: () {
          when(mockGetWathclistTvSeries.excute()).thenAnswer(
            (_) async => Right(testTvSeriesList),
          );
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesLoaded(testTvSeriesList),
        ],
        verify: (bloc) {
          verify(mockGetWathclistTvSeries.excute());
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        "should emit [Loading, TvSeriesError] when data is not loaded successfully",
        build: () {
          when(mockGetWathclistTvSeries.excute()).thenAnswer(
            (_) async => Left(DatabaseFailure("Failed")),
          );
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetWathclistTvSeries.excute());
        },
      );
    },
  );
}
