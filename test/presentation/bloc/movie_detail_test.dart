import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  final tId = 1;

  group(
    "get movie detail",
    () {
      test(
        "initial state should be [Initial]",
        () {
          expect(movieDetailBloc.state, MovieDetailInitial());
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "should emit [Loading, FetchSuccess] when data is gotten successfully",
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => Right(testMovieDetail),
          );
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        expect: () => [
          MovieDetailFetchLoading(),
          MovieDetailFetchSuccess(testMovieDetail),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        "should emit [Loading, FetchFailed] when get detail data is failed",
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => Left(ServerFailure("Server Failure")),
          );
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        expect: () => [
          MovieDetailFetchLoading(),
          MovieDetailFetchFailed("Server Failure"),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        },
      );
    },
  );
}
