import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceimpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceimpl(client: mockHttpClient);
  });

  group(
    "get Now Playing Tv Series",
    () {
      final tTvSeries =
          TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/now_playing_tv_series.json'))).tvSeriesList;

      test(
        "should return list of TvSeries Model when the response code is 200",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY"))).thenAnswer(
            (_) async => http.Response(
              readJson("dummy_data/now_playing_tv_series.json"),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              },
            ),
          );

          /// Act
          final result = await dataSource.getNowPlayingTvSeries();

          /// Assert
          expect(result, equals(tTvSeries));
        },
      );

      test(
        "should throw a ServerException when the response code is 404 or other",
        () async {
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY"))).thenAnswer(
            (_) async => http.Response(
              "Not Found",
              404,
            ),
          );

          final call = dataSource.getNowPlayingTvSeries();

          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    "get popular tv series",
    () {
      final tTvSeriesList =
          TvSeriesResponse.fromJson(json.decode(readJson("dummy_data/tv_series_popular.json"))).tvSeriesList;

      test(
        "should return list of tv series when response code is 200(success)",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY"))).thenAnswer(
            (_) async => http.Response(
              readJson("dummy_data/tv_series_popular.json"),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              },
            ),
          );

          /// Act
          final result = await dataSource.getPopularTvSeries();

          /// Assert
          expect(result, tTvSeriesList);
        },
      );

      test(
        "should throw a ServeException when th resopnse code is not 200",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY"))).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );

          /// Act
          final call = dataSource.getPopularTvSeries();

          /// Assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    "get top rated tv series",
    () {
      final tTvSeriesList =
          TvSeriesResponse.fromJson(json.decode(readJson("dummy_data/tv_series_top_rated.json"))).tvSeriesList;

      test(
        "should return list of tv series when response code is 200(success)",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY"))).thenAnswer(
            (_) async => http.Response(
              readJson("dummy_data/tv_series_top_rated.json"),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              },
            ),
          );

          /// Act
          final result = await dataSource.getTopRatedTvSeries();

          /// Assert
          expect(result, tTvSeriesList);
        },
      );

      test(
        "should throw ServerException when response code is not 200",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY"))).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );

          /// Act
          final call = dataSource.getTopRatedTvSeries();

          /// Assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    "get tv series detail",
    () {
      final tId = 1;
      final tTvSeriesDetail =
          TvSeriesDetailResponse.fromJson(json.decode(readJson("dummy_data/tv_series_detail.json")));

      test(
        "should return tv series detail when the response code is 200(success)",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/$tId?$API_KEY"))).thenAnswer(
            (_) async => http.Response(
              readJson("dummy_data/tv_series_detail.json"),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              },
            ),
          );

          /// Act
          final result = await dataSource.getTvSeriesDetail(tId);

          /// Assert
          expect(result, equals(tTvSeriesDetail));
        },
      );

      test(
        "should throw ServerException when response code is not 200",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/$tId?$API_KEY"))).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );

          /// Act
          final call = dataSource.getTvSeriesDetail(tId);

          /// Assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    "get tv series recommendations",
    () {
      final tId = 1;
      final tTvSeriesList =
          TvSeriesResponse.fromJson(json.decode(readJson("dummy_data/tv_series_recommendations.json"))).tvSeriesList;

      test(
        "should return list of tv series model when response code is 200(success)",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/$tId/recommendations?$API_KEY"))).thenAnswer(
            (_) async => http.Response(
              readJson("dummy_data/tv_series_recommendations.json"),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              },
            ),
          );

          /// Act
          final result = await dataSource.getTvSeriesRecommendations(tId);

          /// Assert
          expect(result, tTvSeriesList);
        },
      );

      test(
        "should throw ServerException when response code is not 200",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/$tId/recommendations?$API_KEY"))).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );

          /// Act
          final call = dataSource.getTvSeriesRecommendations(tId);

          /// Assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    "search tv series",
    () {
      final tSearchResult =
          TvSeriesResponse.fromJson(json.decode(readJson("dummy_data/search_game_of_thrones.json"))).tvSeriesList;

      final tQuery = "game";

      test(
        "should return list of tv series when response code is 200(success)",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/search/tv?$API_KEY&query=$tQuery"))).thenAnswer(
            (_) async => http.Response(
              readJson("dummy_data/search_game_of_thrones.json"),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              },
            ),
          );

          /// Act
          final result = await dataSource.searchTvSeries(tQuery);

          /// Assert
          expect(result, tSearchResult);
        },
      );

      test(
        "should throw ServerException when response code is not 200",
        () async {
          /// Arrange
          when(mockHttpClient.get(Uri.parse("$BASE_URL/search/tv?$API_KEY&query=$tQuery"))).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );

          /// Act
          final call = dataSource.searchTvSeries(tQuery);

          /// Assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
