import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/home/about_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home/homepage.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/home/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/home/watchlist_page.dart';
import 'package:ditonton/presentation/pages/tv_series/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(
            create: (_) => di.locator<MovieDetailBloc>(),
          ),
          BlocProvider<MovieWatchlistBloc>(
            create: (_) => di.locator<MovieWatchlistBloc>(),
          ),
          BlocProvider<MovieRecommendationBloc>(
            create: (_) => di.locator<MovieRecommendationBloc>(),
          ),
          BlocProvider<MovieNowPlayingBloc>(
            create: (_) => di.locator<MovieNowPlayingBloc>(),
          ),
          BlocProvider<MoviePopularBloc>(
            create: (_) => di.locator<MoviePopularBloc>(),
          ),
          BlocProvider<MovieTopRatedBloc>(
            create: (_) => di.locator<MovieTopRatedBloc>(),
          ),
          BlocProvider<TvSeriesDetailBloc>(
            create: (_) => di.locator<TvSeriesDetailBloc>(),
          ),
          BlocProvider<TvSeriesWatchlistBloc>(
            create: (_) => di.locator<TvSeriesWatchlistBloc>(),
          ),
          BlocProvider<TvSeriesRecommendationBloc>(
            create: (_) => di.locator<TvSeriesRecommendationBloc>(),
          ),
          BlocProvider<TvSeriesNowPlayingBloc>(
            create: (_) => di.locator<TvSeriesNowPlayingBloc>(),
          ),
          BlocProvider<TvSeriesPopularBloc>(
            create: (_) => di.locator<TvSeriesPopularBloc>(),
          ),
          BlocProvider<TvSeriesTopRatedBloc>(
            create: (_) => di.locator<TvSeriesTopRatedBloc>(),
          ),
          BlocProvider<WatchlistMovieBloc>(
            create: (_) => di.locator<WatchlistMovieBloc>(),
          ),
          BlocProvider<WatchlistTvSeriesBloc>(
            create: (_) => di.locator<WatchlistTvSeriesBloc>(),
          ),
          BlocProvider<SearchMovieBloc>(
            create: (_) => di.locator<SearchMovieBloc>(),
          ),
          BlocProvider<SearchTvSeriesBloc>(
            create: (_) => di.locator<SearchTvSeriesBloc>(),
          ),
        ],
        child: MaterialApp(
          title: 'Ditonton',
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          home: HomePage(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(builder: (_) => HomePage());
              case NowPlayingTvSeriesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => NowPlayingTvSeriesPage());
              case PopularMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
              case PopularTvSeriesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
              case TopRatedMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
              case TopRatedTvSeriesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
              case MovieDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case TvSeriesDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => TvSeriesDetailPage(id: id),
                  settings: settings,
                );
              case SearchPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchPage());
              case WatchlistPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => WatchlistPage());
              case AboutPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => AboutPage());
              default:
                return MaterialPageRoute(builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          },
        ),
      ),
    );
  }
}
