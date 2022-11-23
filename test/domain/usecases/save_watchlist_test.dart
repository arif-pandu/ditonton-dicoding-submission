import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SaveWatchlist(mockMovieRepository, mockTVSeriesRepository);
  });

  test('should save movie to the movie repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testMovieDetail)).thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.executeMovie(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });

  test(
    "should save tv series to the tv series repository",
    () async {
      /// Arrange
      when(mockTVSeriesRepository.saveWatchlist(testTvSeriesDetail)).thenAnswer(
        (_) async => Right("Added to Watchlist"),
      );

      /// Act
      final result = await usecase.executeTvSeries(testTvSeriesDetail);

      /// Assert
      verify(mockTVSeriesRepository.saveWatchlist(testTvSeriesDetail));
      expect(result, Right("Added to Watchlist"));
    },
  );
}
