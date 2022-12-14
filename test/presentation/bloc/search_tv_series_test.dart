import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_series_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesBloc = SearchTvSeriesBloc(mockSearchTvSeries);
  });

  final tTvSeriesModel = TvSeries(
    posterPath: "/7WUHnWGx5OO145IRxPDUkQSh4C7.jpg",
    popularity: 599.394,
    id: 1399,
    backdropPath: "/2OMB0ynKlyIenMJWI2Dy9IWT4c.jpg",
    voteAverage: 8.4,
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
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
        "initial state should be [Empty]",
        () {
          expect(searchTvSeriesBloc.state, SearchTvSeriesEmpty());
        },
      );

      blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
        "should emit [Loading, HasResult] when data is gotten successfully",
        build: () {
          when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => Right(tTvSeriesList),
          );
          return searchTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnQueryTvSeriesChanged(tQuery)),
        wait: Duration(milliseconds: 500),
        expect: () => [
          SearchTvSeriesLoading(),
          SearchTvSeriesHasResult(tTvSeriesList),
        ],
        verify: (bloc) {
          verify(mockSearchTvSeries.execute(tQuery));
        },
      );

      blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
        "should emit [Loading, Error] when search is unsuccessfull",
        build: () {
          when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => Left(ServerFailure("Server Failure")),
          );
          return searchTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnQueryTvSeriesChanged(tQuery)),
        wait: Duration(milliseconds: 500),
        expect: () => [
          SearchTvSeriesLoading(),
          SearchTvSeriesError("Server Failure"),
        ],
        verify: (bloc) {
          verify(mockSearchTvSeries.execute(tQuery));
        },
      );
    },
  );
}
