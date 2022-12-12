import 'dart:async';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(OnFetchWatchlistMovie());
      context.read<WatchlistTvSeriesBloc>().add(OnFetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnFetchWatchlistMovie());
    context.read<WatchlistTvSeriesBloc>().add(OnFetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Watchlist"),
          bottom: TabBar(
            tabs: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Icon(Icons.movie_rounded),
                  ),
                  Text("Movie"),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Icon(Icons.tv_rounded),
                  ),
                  Text("Tv Series"),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                builder: (context, state) {
                  if (state is WatchlistMovieInitial || state is WatchlistMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistMovieLoaded) {
                    return ListView.builder(
                      itemCount: state.watchlistMovies.length,
                      itemBuilder: (context, index) {
                        final movie = state.watchlistMovies[index];
                        return CardThumbnail(
                          ContentCategory.Film,
                          movie.id,
                          movie.posterPath,
                          movie.title,
                          movie.overview,
                        );
                      },
                    );
                  } else if (state is WatchlistMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Center(
                      child: Text(state.runtimeType.toString()),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
                builder: (context, state) {
                  if (state is WatchlistTvSeriesInitial || state is WatchlistTvSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistTvSeriesLoaded) {
                    return ListView.builder(
                      itemCount: state.watchlistTvSeries.length,
                      itemBuilder: (context, index) {
                        final tvSeries = state.watchlistTvSeries[index];
                        return CardThumbnail(
                          ContentCategory.Film,
                          tvSeries.id,
                          tvSeries.posterPath,
                          tvSeries.name,
                          tvSeries.overview,
                        );
                      },
                    );
                  } else if (state is WatchlistTvSeriesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Center(
                      child: Text(state.runtimeType.toString()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
