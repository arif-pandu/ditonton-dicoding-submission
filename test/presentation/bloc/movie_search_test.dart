import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group(
    'search movies',
    () {
      test(
        "initial state should be [Empty]",
        () {
          expect(searchMovieBloc.state, SearchMovieEmpty());
        },
      );

      blocTest<SearchMovieBloc, SearchMovieState>(
        "should emit [Loading, HasResult] when data is gotten successfully",
        build: () {
          when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => Right(tMovieList),
          );
          return searchMovieBloc;
        },
        act: (bloc) => bloc.add(OnQueryMovieChanged(tQuery)),
        wait: Duration(milliseconds: 500),
        expect: () => [
          SearchMovieLoading(),
          SearchMovieHasResult(tMovieList),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );

      blocTest<SearchMovieBloc, SearchMovieState>(
        "should emit [Loading, Error] when search is unsuccessful",
        build: () {
          when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => Left(ServerFailure("Server Failure")),
          );
          return searchMovieBloc;
        },
        act: (bloc) => bloc.add(OnQueryMovieChanged(tQuery)),
        wait: Duration(milliseconds: 500),
        expect: () => [
          SearchMovieLoading(),
          SearchMovieError("Server Failure"),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );
    },
  );
}
