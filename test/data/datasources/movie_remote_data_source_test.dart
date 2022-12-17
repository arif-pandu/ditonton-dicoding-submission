import 'dart:convert';

import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

// class MockIOClient extends Mock implements IOClient {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockSSLPinning mockSSLPinning;

  setUp(() {
    mockSSLPinning = MockSSLPinning();
    dataSource = MovieRemoteDataSourceImpl(sslPinning: mockSSLPinning);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/now_playing_movie.json'))).movieList;

    test('should return list of Movie Model when the response code is 200', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'))).thenAnswer(
        (_) async => Response(
          readJson('dummy_data/now_playing_movie.json'),
          200,
        ),
      );
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/movie_popular.json'))).movieList;

    test('should return list of movies when response is success (200)', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async => Response(readJson('dummy_data/movie_popular.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/movie_top_rated.json'))).movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response(readJson('dummy_data/movie_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async => Response(readJson('dummy_data/movie_detail.json'), 200));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/movie_recommendations.json'))).movieList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response(readJson('dummy_data/movie_recommendations.json'), 200));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/search_spiderman_movie.json'))).movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response(readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockSSLPinning.getResponse(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
