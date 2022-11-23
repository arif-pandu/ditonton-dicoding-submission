import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockTVSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test(
    "should get list of tv series from the repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.getNowPlayingTvSeries()).thenAnswer(
        (_) async => Right(tTvSeries),
      );

      /// Act
      final result = await usecase.execute();

      /// Assert
      expect(result, Right(tTvSeries));
    },
  );
}
