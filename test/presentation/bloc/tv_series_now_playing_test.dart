import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_now_playing_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late TvSeriesNowPlayingBloc tvSeriesNowPlayingBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    tvSeriesNowPlayingBloc = TvSeriesNowPlayingBloc(mockGetNowPlayingTvSeries);
  });

  group(
    "get now playing TvSeries",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(tvSeriesNowPlayingBloc.state, TvSeriesNowPlayingInitial());
        },
      );

      blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
        "should emit [Loading, Loaded] when data is gotten successfully",
        build: () {
          when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => Right(testTvSeriesList),
          );
          return tvSeriesNowPlayingBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesNowPlaying()),
        expect: () => [
          TvSeriesNowPlayingLoading(),
          TvSeriesNowPlayingLoaded(testTvSeriesList),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvSeries.execute());
        },
      );

      blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
        "should emit [Loading, Error] when data is failed to get",
        build: () {
          when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => Left(ServerFailure("Failed")),
          );
          return tvSeriesNowPlayingBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesNowPlaying()),
        expect: () => [
          TvSeriesNowPlayingLoading(),
          TvSeriesNowPlayingError("Failed"),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvSeries.execute());
        },
      );
    },
  );
}
