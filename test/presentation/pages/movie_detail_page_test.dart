import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
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

  void prepareInitStream() {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockMovieWatchlistBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockMovieRecommendationBloc.stream).thenAnswer((_) => Stream.empty());
  }

  void prepareInitState() {
    when(mockMovieDetailBloc.state).thenReturn(MovieDetailInitial());
    when(mockMovieWatchlistBloc.state).thenReturn(MovieWatchlistInitial());
    when(mockMovieRecommendationBloc.state).thenReturn(MovieRecommendationInitial());
  }

  void prepareLoadingState() {
    when(mockMovieDetailBloc.state).thenReturn(MovieDetailFetchLoading());
    when(mockMovieRecommendationBloc.state).thenReturn(MovieRecommendationLoading());
  }

  void prepareLoadedState(bool isWatchlist) {
    when(mockMovieDetailBloc.state).thenReturn(MovieDetailFetchSuccess(testMovieDetail));
    when(mockMovieWatchlistBloc.state).thenReturn(MovieWatchlistStatus(isWatchlist));
    when(mockMovieRecommendationBloc.state).thenReturn(MovieRecommendationLoaded(testMovieList));
  }

  MultiBlocProvider buildRequiredWidget(MockMovieDetailBloc mockMovieDetailBloc,
      MockMovieWatchlistBloc mockMovieWatchlistBloc, MockMovieRecommendationBloc mockMovieRecommendationBloc, int tId) {
    return MultiBlocProvider(
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
    );
  }

  final tId = 1;

  group(
    "shows Movie detail page",
    () {
      testWidgets(
        'Initial Page',
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          await tester.pumpWidget(
            buildRequiredWidget(mockMovieDetailBloc, mockMovieWatchlistBloc, mockMovieRecommendationBloc, tId),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        "should displays detail content of a Movie if Fetch Success",
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          prepareLoadingState();

          prepareLoadedState(false);

          await tester.pumpWidget(
            buildRequiredWidget(
              mockMovieDetailBloc,
              mockMovieWatchlistBloc,
              mockMovieRecommendationBloc,
              tId,
            ),
          );

          expect(find.byType(SafeArea), findsOneWidget);
        },
      );

      testWidgets(
        "should displays check icon if Movie is added to watchlist",
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          prepareLoadingState();

          prepareLoadedState(true);

          await tester.pumpWidget(
            buildRequiredWidget(
              mockMovieDetailBloc,
              mockMovieWatchlistBloc,
              mockMovieRecommendationBloc,
              tId,
            ),
          );

          expect(find.byIcon(Icons.check), findsOneWidget);
        },
      );

      testWidgets(
        "should displays add icon if Movie is not added to watchlist",
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          prepareLoadingState();

          prepareLoadedState(false);

          await tester.pumpWidget(
            buildRequiredWidget(
              mockMovieDetailBloc,
              mockMovieWatchlistBloc,
              mockMovieRecommendationBloc,
              tId,
            ),
          );

          expect(find.byIcon(Icons.add), findsOneWidget);
        },
      );
    },
  );
}
