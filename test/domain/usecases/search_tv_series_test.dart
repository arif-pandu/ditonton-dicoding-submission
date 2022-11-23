import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SearchTvSeries(mockTVSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];
  final tQuery = "Games";

  test(
    "should get list of tv series from the repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.searchTvSeries(tQuery)).thenAnswer(
        (_) async => Right(tTvSeries),
      );

      /// Act
      final result = await usecase.execute(tQuery);

      /// Assert
      expect(result, Right(tTvSeries));
    },
  );
}
