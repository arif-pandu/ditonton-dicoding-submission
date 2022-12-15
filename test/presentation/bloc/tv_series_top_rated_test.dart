import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvSeries);
  });

  group(
    "get top rated TvSeries",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(tvSeriesTopRatedBloc.state, TvSeriesTopRatedInitial());
        },
      );

      blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
        "should emot [Loading, Loaded] when data is gotten successfully",
        build: () {
          when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => Right(testTvSeriesList),
          );
          return tvSeriesTopRatedBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesTopRated()),
        expect: () => [
          TvSeriesTopRatedLoading(),
          TvSeriesTopRatedLoaded(testTvSeriesList),
        ],
        verify: (bloc) {
          verify(mockGetTopRatedTvSeries.execute());
        },
      );

      blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
        "should emot [Loading, Error] when data is failed to get",
        build: () {
          when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return tvSeriesTopRatedBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesTopRated()),
        expect: () => [
          TvSeriesTopRatedLoading(),
          TvSeriesTopRatedError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetTopRatedTvSeries.execute());
        },
      );
    },
  );
}
