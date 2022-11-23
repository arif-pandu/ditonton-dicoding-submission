import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTVSeriesRepository);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test(
    "should get list of tv series from the repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.getTvSeriesRecommendations(tId)).thenAnswer(
        (_) async => Right(tTvSeries),
      );

      /// Act
      final result = await usecase.execute(tId);

      /// Assert
      expect(result, Right(tTvSeries));
    },
  );
}
