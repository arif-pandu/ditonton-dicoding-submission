import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTvSeriesDetail(mockTVSeriesRepository);
  });

  final tId = 1;

  test(
    "should get a tv series detail from the repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.getTvSeriesDetail(tId)).thenAnswer(
        (_) async => Right(testTvSeriesDetail),
      );

      /// Act
      final result = await usecase.execute(tId);

      /// Assert
      expect(result, Right(testTvSeriesDetail));
    },
  );
}
