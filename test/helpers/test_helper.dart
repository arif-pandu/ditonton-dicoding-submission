import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_resorce.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import 'test_helper.mocks.dart';

@GenerateMocks([
  MovieRepository,
  TVSeriesRepository,
  MovieRemoteDataSource,
  TvSeriesRemoteDataSource,
  MovieLocalDataSource,
  // TvSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<TvSeriesLocalDataSource>(
    as: #MockTvSeriesLocalDataSource,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late TvSeriesRepositoryImpl tvSeriesRepositoryImpl;
  late MockTvSeriesRemoteDataSource mockTvSeriesRemoteDataSource;
  late MockTvSeriesLocalDataSource mockTvSeriesLocalDataSource;

  setUp(() {
    mockTvSeriesLocalDataSource = MockTvSeriesLocalDataSource();
    mockTvSeriesRemoteDataSource = MockTvSeriesRemoteDataSource();
    tvSeriesRepositoryImpl = TvSeriesRepositoryImpl(
      remoteDataSource: mockTvSeriesRemoteDataSource,
      localDataSource: mockTvSeriesLocalDataSource,
    );
  });

  test(
    "mocking local data source tv Series",
    () async {
      when(MockTvSeriesLocalDataSource().insertWatchlist(testTvSeriesTable)).thenAnswer(
        (_) async => "Added to watchlist",
      );

      final result = await tvSeriesRepositoryImpl.saveWatchlist(testTvSeriesDetail);

      expect(result, Right("Added to watchlist"));
    },
  );
}
