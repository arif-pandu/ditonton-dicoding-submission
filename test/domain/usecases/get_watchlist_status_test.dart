import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchListStatus(mockMovieRepository, mockTVSeriesRepository);
  });

  test('should get watchlist status from movie repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await usecase.executeMovie(1);
    // assert
    expect(result, true);
  });

  test(
    "should get watchlist status from tv series repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);

      /// Act
      final result = await usecase.executeTvSeries(1);

      /// Assert
      expect(result, true);
    },
  );
}
