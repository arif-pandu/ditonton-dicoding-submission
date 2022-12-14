import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetWathclistTvSeries,
])
void main() {
  late WatchlistTvSeriesNotifier provider;
  late MockGetWathclistTvSeries mockGetWathclistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWathclistTvSeries = MockGetWathclistTvSeries();
    provider = WatchlistTvSeriesNotifier(getWathclistTvSeries: mockGetWathclistTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  test(
    "should change tv series data when data is gotten successfully",
    () async {
      /// Arrange
      when(mockGetWathclistTvSeries.excute()).thenAnswer(
        (_) async => Right([testWatchlistTvSeries]),
      );

      /// Act
      await provider.fetchWatchlistTvSeries();

      /// Assert
      expect(provider.watchlistState, RequestState.Loaded);
      expect(provider.watchlistTvSeries, [testWatchlistTvSeries]);
      expect(listenerCallCount, 2);
    },
  );

  test(
    "should return error when data is not success",
    () async {
      /// Arrange
      when(mockGetWathclistTvSeries.excute()).thenAnswer(
        (_) async => Left(DatabaseFailure("Can't get data")),
      );

      /// Act
      await provider.fetchWatchlistTvSeries();

      /// Assert
      expect(provider.watchlistState, RequestState.Error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    },
  );
}
