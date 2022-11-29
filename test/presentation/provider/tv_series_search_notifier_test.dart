import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([
  SearchTvSeries,
])
void main() {
  late TvSeriesSearchNotifier provider;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    provider = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeriesModel = TvSeries(
    posterPath: "/7WUHnWGx5OO145IRxPDUkQSh4C7.jpg",
    popularity: 599.394,
    id: 1399,
    backdropPath: "/2OMB0ynKlyIenMJWI2Dy9IWT4c.jpg",
    voteAverage: 8.4,
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    firstAirDate: "2011-04-17",
    originCountry: ["US"],
    genreIds: [10765, 18, 10759],
    originalLanguage: "en",
    voteCount: 19843,
    name: "Game of Thrones",
    originalName: "Game of Thrones",
  );

  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  final tQuery = "game";

  group(
    "search tv series",
    () {
      test(
        "should change state to loading when usecase is called",
        () async {
          /// Arrange
          when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => Right(tTvSeriesList),
          );

          /// Act
          provider.fetchMovieSearch(tQuery);

          /// Assert
          expect(provider.state, RequestState.Loading);
        },
      );

      test(
        "should change search result data when data is gotten successfully",
        () async {
          /// Arrange
          when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => Right(tTvSeriesList),
          );

          /// Act
          await provider.fetchMovieSearch(tQuery);

          /// Assert
          expect(provider.state, RequestState.Loaded);
          expect(provider.searchResult, tTvSeriesList);
          expect(listenerCallCount, 2);
        },
      );

      test(
        "should return error when data is not success",
        () async {
          /// Arrange
          when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => Left(ServerFailure("Server Failure")),
          );

          /// Act
          await provider.fetchMovieSearch(tQuery);

          /// Assert
          expect(provider.state, RequestState.Error);
          expect(provider.message, "Server Failure");
          expect(listenerCallCount, 2);
        },
      );
    },
  );
}
