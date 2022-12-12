import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/home/about_page.dart';
import 'package:ditonton/presentation/pages/home/search_page.dart';
import 'package:ditonton/presentation/pages/sub_page/movie_page.dart';
import 'package:ditonton/presentation/pages/sub_page/tv_series_page.dart';
import 'package:ditonton/presentation/pages/home/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomePage> {
  int _pageIndex = 0;
  static const List<Widget> listPage = [
    MoviePage(),
    TvSeriesPage(),
  ];

  void _onTapIcon(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(OnFetchMovieNowPlaying());
      context.read<MoviePopularBloc>().add(OnFetchMoviePopular());
      context.read<MovieTopRatedBloc>().add(OnFetchMovieTopRated());

      context.read<TvSeriesNowPlayingBloc>().add(OnFetchTvSeriesNowPlaying());
      context.read<TvSeriesPopularBloc>().add(OnFetchTvSeriesPopular());
      context.read<TvSeriesTopRatedBloc>().add(OnFetchTvSeriesTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.home_rounded),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt_rounded),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapIcon,
        currentIndex: _pageIndex,
        backgroundColor: kRichBlack,
        selectedItemColor: kMikadoYellow,
        unselectedItemColor: kDavysGrey,
        items: [
          BottomNavigationBarItem(
            label: "Movie",
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            label: "Series",
            icon: Icon(Icons.movie_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: listPage.elementAt(_pageIndex),
        ),
      ),
    );
  }
}
