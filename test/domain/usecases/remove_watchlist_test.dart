import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = RemoveWatchlist(mockMovieRepository, mockTVSeriesRepository);
  });

  test('should remove watchlist movie from movie repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail)).thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.executeMovie(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });

  test(
    "should remove watchlist tv series from tv series repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.removeWatchlist(testTvSeriesDetail)).thenAnswer(
        (_) async => Right("Removed from watchlist"),
      );

      /// Act
      final result = await usecase.executeTvSeries(testTvSeriesDetail);

      /// Assert
      verify(mockTVSeriesRepository.removeWatchlist(testTvSeriesDetail));
      expect(result, Right("Removed from watchlist"));
    },
  );
}
