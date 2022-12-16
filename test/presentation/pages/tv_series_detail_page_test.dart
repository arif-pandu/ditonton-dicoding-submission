import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks(
  [
    TvSeriesDetailBloc,
    TvSeriesWatchlistBloc,
    TvSeriesRecommendationBloc,
  ],
)
void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesWatchlistBloc mockTvSeriesWatchlistBloc;
  late MockTvSeriesRecommendationBloc mockTvSeriesRecommendationBloc;

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesWatchlistBloc = MockTvSeriesWatchlistBloc();
    mockTvSeriesRecommendationBloc = MockTvSeriesRecommendationBloc();
  });

  void prepareInitStream() {
    when(mockTvSeriesDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvSeriesWatchlistBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvSeriesRecommendationBloc.stream).thenAnswer((_) => Stream.empty());
  }

  void prepareInitState() {
    when(mockTvSeriesDetailBloc.state).thenReturn(TvSeriesDetailInitial());
    when(mockTvSeriesWatchlistBloc.state).thenReturn(TvSeriesWatchlistInitial());
    when(mockTvSeriesRecommendationBloc.state).thenReturn(TvSeriesRecommendationInitial());
  }

  void prepareLoadingState() {
    when(mockTvSeriesDetailBloc.state).thenReturn(TvSeriesDetailFetchLoading());
    when(mockTvSeriesRecommendationBloc.state).thenReturn(TvSeriesRecommendationLoading());
  }

  void prepareLoadedState(bool isWatchlist) {
    when(mockTvSeriesDetailBloc.state).thenReturn(TvSeriesDetailFetchSuccess(testTvSeriesDetail));
    when(mockTvSeriesWatchlistBloc.state).thenReturn(TvSeriesWatchlistStatus(isWatchlist));
    when(mockTvSeriesRecommendationBloc.state).thenReturn(TvSeriesRecommendationLoaded(testTvSeriesList));
  }

  MultiBlocProvider buildRequiredWidget(
      MockTvSeriesDetailBloc mockTvSeriesDetailBloc,
      MockTvSeriesWatchlistBloc mockTvSeriesWatchlistBloc,
      MockTvSeriesRecommendationBloc mockTvSeriesRecommendationBloc,
      int tId) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (_) => mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesWatchlistBloc>(
          create: (_) => mockTvSeriesWatchlistBloc,
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (_) => mockTvSeriesRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: TvSeriesDetailPage(id: tId),
      ),
    );
  }

  final tId = 1;

  group(
    "shows TvSeries detail page",
    () {
      testWidgets(
        "Initial Page",
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          await tester.pumpWidget(buildRequiredWidget(
            mockTvSeriesDetailBloc,
            mockTvSeriesWatchlistBloc,
            mockTvSeriesRecommendationBloc,
            tId,
          ));

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        "should displays detail content of a TvSeries if fetch success",
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          prepareLoadingState();

          prepareLoadedState(false);

          await tester.pumpWidget(
            buildRequiredWidget(
              mockTvSeriesDetailBloc,
              mockTvSeriesWatchlistBloc,
              mockTvSeriesRecommendationBloc,
              tId,
            ),
          );

          expect(find.byType(SafeArea), findsOneWidget);
        },
      );

      testWidgets(
        "should displays check icon if TvSeries is added to watchlist",
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          prepareLoadingState();

          prepareLoadedState(true);

          await tester.pumpWidget(buildRequiredWidget(
            mockTvSeriesDetailBloc,
            mockTvSeriesWatchlistBloc,
            mockTvSeriesRecommendationBloc,
            tId,
          ));

          expect(find.byIcon(Icons.check), findsOneWidget);
        },
      );

      testWidgets(
        "should displays add icon if TvSeries is added not added watchlist",
        (WidgetTester tester) async {
          prepareInitStream();
          prepareInitState();

          prepareLoadingState();

          prepareLoadedState(false);

          await tester.pumpWidget(buildRequiredWidget(
            mockTvSeriesDetailBloc,
            mockTvSeriesWatchlistBloc,
            mockTvSeriesRecommendationBloc,
            tId,
          ));

          expect(find.byIcon(Icons.add), findsOneWidget);
        },
      );
    },
  );
}
