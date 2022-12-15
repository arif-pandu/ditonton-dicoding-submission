import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesPopularBloc = TvSeriesPopularBloc(mockGetPopularTvSeries);
  });

  group(
    "get popular TvSeries",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(tvSeriesPopularBloc.state, TvSeriesPopularInitial());
        },
      );

      blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
        "should emit [Loading, Loaded] when data is gotten successfully",
        build: () {
          when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => Right(testTvSeriesList),
          );
          return tvSeriesPopularBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesPopular()),
        expect: () => [
          TvSeriesPopularLoading(),
          TvSeriesPopularLoaded(testTvSeriesList),
        ],
        verify: (bloc) {
          verify(mockGetPopularTvSeries.execute());
        },
      );

      blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
        "should emit [Loading, Error] when data is failed to get",
        build: () {
          when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return tvSeriesPopularBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesPopular()),
        expect: () => [
          TvSeriesPopularLoading(),
          TvSeriesPopularError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetPopularTvSeries.execute());
        },
      );
    },
  );
}
