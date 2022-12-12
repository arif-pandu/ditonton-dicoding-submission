import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(builder: (context, search, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) {
                  context.read<SearchMovieBloc>().add(OnQueryMovieChanged(query));
                  context.read<SearchTvSeriesBloc>().add(OnQueryTvSeriesChanged(query));
                },
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Search ',
                    style: kHeading6,
                  ),
                  DropdownButton<int>(
                    value: search.index,
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: Text(
                          "Movie",
                          style: kHeading6,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          "Tv Series",
                          style: kHeading6,
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      search.index = value!;
                    },
                  ),
                ],
              ),
              listResult[search.index],
            ],
          ),
        ),
      );
    });
  }
}

final listResult = [_MovieResult(), _TvSeriesResult()];

class _MovieResult extends StatelessWidget {
  const _MovieResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
        builder: (context, state) {
          if (state is SearchMovieEmpty) {
            return Container();
          } else if (state is SearchMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchMovieHasResult) {
            return ListView.builder(
              itemCount: state.movieResult.length,
              itemBuilder: (context, index) {
                final movie = state.movieResult[index];
                return CardThumbnail(
                  ContentCategory.Film,
                  movie.id,
                  movie.posterPath,
                  movie.title,
                  movie.overview,
                );
              },
            );
          } else if (state is SearchMovieError) {
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
    );
  }
}

class _TvSeriesResult extends StatelessWidget {
  const _TvSeriesResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
        builder: (context, state) {
          if (state is SearchTvSeriesEmpty) {
            return Container();
          } else if (state is SearchTvSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchTvSeriesHasResult) {
            return ListView.builder(
              itemCount: state.tvSeriesResult.length,
              itemBuilder: (context, index) {
                final tvSeries = state.tvSeriesResult[index];
                return CardThumbnail(
                  ContentCategory.TvSeries,
                  tvSeries.id,
                  tvSeries.posterPath,
                  tvSeries.name,
                  tvSeries.overview,
                );
              },
            );
          } else if (state is SearchTvSeriesError) {
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
    );
  }
}
