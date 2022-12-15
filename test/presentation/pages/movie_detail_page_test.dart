import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_page_test.mocks.dart';

@GenerateMocks(
  [
    MovieDetailBloc,
    MovieWatchlistBloc,
    MovieRecommendationBloc,
  ],
)
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
  });

  final tId = 1;
  testWidgets(
    'Initial Page',
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
      when(mockMovieWatchlistBloc.stream).thenAnswer((_) => Stream.empty());
      when(mockMovieRecommendationBloc.stream).thenAnswer((_) => Stream.empty());

      when(mockMovieDetailBloc.state).thenReturn(MovieDetailInitial());
      when(mockMovieWatchlistBloc.state).thenReturn(MovieWatchlistInitial());
      when(mockMovieRecommendationBloc.state).thenReturn(MovieRecommendationInitial());

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<MovieDetailBloc>(
              create: (_) => mockMovieDetailBloc,
            ),
            BlocProvider<MovieWatchlistBloc>(
              create: (_) => mockMovieWatchlistBloc,
            ),
            BlocProvider<MovieRecommendationBloc>(
              create: (_) => mockMovieRecommendationBloc,
            ),
          ],
          child: MaterialApp(
            home: MovieDetailPage(id: tId),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
