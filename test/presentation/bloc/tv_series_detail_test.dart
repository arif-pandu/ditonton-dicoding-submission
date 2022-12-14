import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });

  final tId = 1;

  group(
    'get tv series detail',
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(tvSeriesDetailBloc.state, TvSeriesDetailInitial());
        },
      );

      blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
        "should emit [Loading, FetchSuccess] when data is gotten successfully",
        build: () {
          when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => Right(testTvSeriesDetail),
          );
          return tvSeriesDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesDetail(tId)),
        expect: () => [
          TvSeriesDetailFetchLoading(),
          TvSeriesDetailFetchSuccess(testTvSeriesDetail),
        ],
        verify: (bloc) {
          verify(mockGetTvSeriesDetail.execute(tId));
        },
      );

      blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
        "should emit [Loading, FetchFailed] when get detail data is failed",
        build: () {
          when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure("Server Failure")),
          );
          return tvSeriesDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesDetail(tId)),
        expect: () => [
          TvSeriesDetailFetchLoading(),
          TvSeriesDetailFetchFailed("Server Failure"),
        ],
        verify: (bloc) {
          verify(mockGetTvSeriesDetail.execute(tId));
        },
      );
    },
  );
}
