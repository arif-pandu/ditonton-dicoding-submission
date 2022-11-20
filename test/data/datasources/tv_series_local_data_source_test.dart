import 'package:ditonton/data/datasources/tv_series_local_data_resorce.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/common/exception.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group(
    "save watchlist",
    () {
      test(
        "should return success message when insert to database is success",
        () async {
          /// Arrange
          when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable)).thenAnswer(
            (_) async => 1,
          );

          /// Act
          final result = await dataSource.insertWatchlist(testTvSeriesTable);

          /// Assert
          expect(result, "Added to Watchlist");
        },
      );

      test(
        "should throw DatabaseException when insert to database is failed",
        () async {
          /// Arrange
          when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable)).thenThrow(
            Exception(),
          );

          /// Act
          final call = dataSource.insertWatchlist(testTvSeriesTable);

          /// Assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        },
      );
    },
  );
  group(
    'remove watchlist',
    () {
      test(
        "should return success message when remove from database is success",
        () async {
          /// Arrange
          when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable)).thenAnswer(
            (_) async => 1,
          );

          /// Act
          final result = await dataSource.removeWatchlist(testTvSeriesTable);

          /// Assert
          expect(result, "Removed from Watchlist");
        },
      );

      test(
        "should throw DatabaseException when remove from database is failed",
        () async {
          /// Arrange
          when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable)).thenThrow(
            Exception(),
          );

          /// Act
          final call = dataSource.removeWatchlist(testTvSeriesTable);

          /// Assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        },
      );
    },
  );

  group(
    "get tvSeries detail by id",
    () {
      final tId = 1;

      test(
        "should return tvSeries Detail Table when data is found",
        () async {
          /// Arrange
          when(mockDatabaseHelper.getTvSeriesById(tId)).thenAnswer((_) async => testTvSeriesMap);

          /// Act
          final result = await dataSource.getTvSeriesById(tId);

          /// Assert
          expect(result, testTvSeriesTable);
        },
      );

      test(
        "should return null when data is not found",
        () async {
          /// Arrange
          when(mockDatabaseHelper.getTvSeriesById(tId)).thenAnswer((_) async => null);

          /// Act
          final result = await dataSource.getTvSeriesById(tId);

          /// Assert
          expect(result, null);
        },
      );
    },
  );

  group(
    "get watchlist tvSeries",
    () {
      test(
        "should return list of TvSeries from database",
        () async {
          /// Arrange
          when(mockDatabaseHelper.getWatchlistTvSeries()).thenAnswer(
            (_) async => [testTvSeriesMap],
          );

          /// Act
          final result = await dataSource.getWatchlistTvSeries();

          /// Assert
          expect(result, [testTvSeriesTable]);
        },
      );
    },
  );
}
