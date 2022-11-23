import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWathclistTvSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWathclistTvSeries(mockTVSeriesRepository);
  });

  test(
    "should get list of tv series from repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.getWatchlistTvSeries()).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );

      /// Act
      final result = await usecase.excute();

      /// Assert
      expect(result, Right(testTvSeriesList));
    },
  );
}
