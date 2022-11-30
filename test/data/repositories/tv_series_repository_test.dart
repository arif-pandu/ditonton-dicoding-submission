import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TVSeriesModel(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );

  final tTvSeries = TvSeries(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );

  final tTvSeriesModelList = <TVSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group(
    "Now Playing Tv Series",
    () {
      test(
        "should return remote data when the call to remote data source is successful",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries()).thenAnswer(
            (_) async => tTvSeriesModelList,
          );

          /// Act
          final result = await repository.getNowPlayingTvSeries();

          /// Assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());

          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          /// Arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries()).thenThrow(
            ServerException(),
          );

          /// Act
          final result = await repository.getNowPlayingTvSeries();

          /// Assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          expect(result, equals(Left(ServerFailure(""))));
        },
      );

      test(
        'should return connection failure when the device is not connected to internet',
        () async {
          /// Arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries()).thenThrow(
            SocketException("Failed to connect to the network"),
          );

          /// Act
          final result = await repository.getNowPlayingTvSeries();

          /// Assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          expect(result, equals(Left(ConnectionFailure("Failed to connect to the network"))));
        },
      );
    },
  );

  group(
    "Popular Tv Series",
    () {
      test(
        "should return tv series list when call to data source is success",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getPopularTvSeries()).thenAnswer(
            (_) async => tTvSeriesModelList,
          );

          /// Act
          final result = await repository.getPopularTvSeries();

          /// Assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        },
      );

      test(
        'should return server failure when call to data source is unsuccessful',
        () async {
          /// Arrange
          when(mockRemoteDataSource.getPopularTvSeries()).thenThrow(
            ServerException(),
          );

          /// Act
          final result = await repository.getPopularTvSeries();

          /// Assert
          expect(result, Left(ServerFailure("")));
        },
      );

      test(
        "should return connection failure when device is not connected to the internet",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getPopularTvSeries()).thenThrow(
            SocketException("Failed to connect to the network"),
          );

          /// Act
          final result = await repository.getPopularTvSeries();

          /// Assert
          expect(result, Left(ConnectionFailure("Failed to connect to the network")));
        },
      );
    },
  );

  group(
    "Top Rated Tv Series",
    () {
      test(
        "should return movie list when call to data source is successful",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTopRatedTvSeries()).thenAnswer(
            (_) async => tTvSeriesModelList,
          );

          /// Act
          final result = await repository.getTopRatedTvSeries();

          /// Assert
          final resultList = result.getOrElse(() => []);

          expect(resultList, tTvSeriesList);
        },
      );

      test(
        "should return ServerFailure when call to data source is unsuccessful",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTopRatedTvSeries()).thenThrow(
            ServerException(),
          );

          /// Act
          final result = await repository.getTopRatedTvSeries();

          /// Assert
          expect(result, Left(ServerFailure("")));
        },
      );

      test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTopRatedTvSeries()).thenThrow(
            SocketException("Failed to connect to the network"),
          );

          /// Act
          final result = await repository.getTopRatedTvSeries();

          /// Assert
          expect(result, Left(ConnectionFailure("Failed to connect to the network")));
        },
      );
    },
  );

  group(
    "Get Tv Series Detail",
    () {
      final tId = 1;
      final tTvSeriesResponse = TvSeriesDetailResponse(
        backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
        genres: [
          GenreModel(
            id: 10765,
            name: "Sci-Fi & Fantasy",
          ),
          GenreModel(
            id: 18,
            name: "Drama",
          ),
        ],
        id: 1399,
        inProduction: false,
        languages: ["en"],
        name: "Game of Thrones",
        numberOfEpisodes: 73,
        numberOfSeasons: 8,
        originCountry: ["US"],
        originalLanguage: "en",
        originalName: "Game of Thrones",
        overview:
            "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
        popularity: 369.594,
        posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
        seasons: [
          SeasonModel(
            airDate: "2010-12-05",
            episodeCount: 64,
            id: 3627,
            name: "Specials",
            overview: "",
            posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
            seasonNumber: 0,
          ),
        ],
        status: "Ended",
        voteAverage: 8.3,
        voteCount: 11504,
      );

      test(
        "should return Tv Series data when the call to remote data source is successful",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId)).thenAnswer(
            (_) async => tTvSeriesResponse,
          );

          /// Act
          final result = await repository.getTvSeriesDetail(tId);

          /// Assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Right(testTvSeriesDetail)));
        },
      );

      test(
        "should return Server Failure when the call to remote data source is unsuccessful",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId)).thenThrow(
            ServerException(),
          );

          /// Act
          final result = await repository.getTvSeriesDetail(tId);

          /// Assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Left(ServerFailure(""))));
        },
      );

      test(
        "should return connection failure when the device is not connected to internet",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId)).thenThrow(
            SocketException("Failed to connect to the network"),
          );

          /// Act
          final result = await repository.getTvSeriesDetail(tId);

          /// Assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Left(ConnectionFailure("Failed to connect to the network"))));
        },
      );
    },
  );

  group(
    "Get Tv Series Recommendations",
    () {
      final tTvSeriesList = <TVSeriesModel>[];
      final tId = 1;

      test(
        "should return data (tvSeries list) when the call is success",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId)).thenAnswer(
            (_) async => tTvSeriesList,
          );

          /// Act
          final result = await repository.getTvSeriesRecommendations(tId);

          /// Assert
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvSeriesList));
        },
      );

      test(
        "should return server failure when call to remote data source is not success",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId)).thenThrow(
            ServerException(),
          );

          /// Act
          final result = await repository.getTvSeriesRecommendations(tId);

          /// Assert
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          expect(result, equals(Left(ServerFailure(""))));
        },
      );

      test(
        "should return connection failure when the device is not connected to the internet",
        () async {
          /// Arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId)).thenThrow(
            SocketException("Failed to conenect to the network"),
          );

          /// Act
          final result = await repository.getTvSeriesRecommendations(tId);

          /// Assert
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));

          expect(result, equals(Left(ConnectionFailure("Failed to connect to the network"))));
        },
      );
    },
  );

  group(
    "Search Tv Series",
    () {
      final tQuery = "games";

      test(
        "should return tv series list when call to data source is success",
        () async {
          /// Arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery)).thenAnswer(
            (_) async => tTvSeriesModelList,
          );

          /// Act
          final result = await repository.searchTvSeries(tQuery);

          /// Assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        },
      );

      test(
        "should return server failure when call to data source is not success",
        () async {
          /// Arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery)).thenThrow(
            ServerException(),
          );

          /// Act
          final result = await repository.searchTvSeries(tQuery);

          /// Assert
          expect(result, Left(ServerFailure("")));
        },
      );

      test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
          /// Arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery)).thenThrow(
            SocketException("Failed to connect to the network"),
          );

          /// Act
          final result = await repository.searchTvSeries(tQuery);

          /// Assert
          expect(result, Left(ConnectionFailure("Failed to connect to the network")));
        },
      );
    },
  );

  group(
    "save watchlist",
    () {
      test(
        "should return succes message when saving is success",
        () async {
          /// Arrange
          when(mockLocalDataSource.insertWatchlist(testTvSeriesTable)).thenAnswer(
            (_) async => "Added to Watchlist",
          );

          /// Act
          final result = await repository.saveWatchlist(testTvSeriesDetail);

          /// Assert
          expect(result, Right(""));
        },
      );

      // test(
      //   "should return DatabaseFailure when saving not success",
      //   () async {
      //     // when(mockLocalDataSource.insertWatchlist(testTvSeriesTable)).thenThrow(
      //     //   DatabaseException("Failed to add watchlist"),
      //     // );

      //     // final result = await repository.saveWatchlist(testTvSeriesDetail);

      //     // expect(result, Left(DatabaseFailure("Failed to add watchlist")));

      //     /// Arrange
      //     when(mockLocalDataSource.insertWatchlist(testTvSeriesTable)).thenThrow(
      //       DatabaseException('Failed to add to watchlist'),
      //     );

      //     /// Act
      //     final result = await repository.saveWatchlist(testTvSeriesDetail);

      //     /// Assert
      //     expect(result, Left(DatabaseFailure("Failed to add to watchlist")));
      //   },
      // );
    },
  );

  // group(
  //   "remove watchlist",
  //   () {
  //     test(
  //       "should return success message when remove is success",
  //       () async {
  //         when(mockLocalDataSource.removeWatchlist(testTvSeriesTable)).thenAnswer(
  //           (_) async => "Removed from watchlist",
  //         );

  //         final result = await repository.removeWatchlist(testTvSeriesDetail);

  //         print("RESULT : " + result.toString());

  //         expect(result, Right("Removed from watchlist"));
  //       },
  //     );
  //   },
  // );

  group(
    "get watchlist status",
    () {
      test(
        "should return watch status wheter data is found",
        () async {
          final tId = 1;
          when(mockLocalDataSource.getTvSeriesById(tId)).thenAnswer(
            (_) async => null,
          );

          final result = await repository.isAddedToWatchlist(tId);

          expect(result, false);
        },
      );
    },
  );

  group(
    "get watchlist tv series",
    () {
      test(
        "should return list of Tv Series",
        () async {
          when(mockLocalDataSource.getWatchlistTvSeries()).thenAnswer(
            (_) async => [testTvSeriesTable],
          );

          final result = await repository.getWatchlistTvSeries();

          final resultList = result.getOrElse(() => []);
          expect(resultList, [testWatchlistTvSeries]);
        },
      );
    },
  );
}
