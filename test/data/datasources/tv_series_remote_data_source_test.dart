import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
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
}
