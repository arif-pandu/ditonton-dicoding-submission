import 'dart:io';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                onSubmitted: (query) {
                  Provider.of<MovieSearchNotifier>(context, listen: false).fetchMovieSearch(query);
                  Provider.of<TvSeriesSearchNotifier>(context, listen: false).fetchMovieSearch(query);
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
      child: Consumer<MovieSearchNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.Loaded) {
            final result = data.searchResult;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = data.searchResult[index];
                return CardThumbnail(
                  ContentCategory.Film,
                  movie.id,
                  movie.posterPath,
                  movie.title,
                  movie.overview,
                );
              },
              itemCount: result.length,
            );
          } else {
            return Container();
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
      child: Consumer<TvSeriesSearchNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.Loaded) {
            final result = data.searchResult;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvSeries = data.searchResult[index];
                return CardThumbnail(
                  ContentCategory.TvSeries,
                  tvSeries.id,
                  tvSeries.posterPath,
                  tvSeries.name,
                  tvSeries.overview,
                );
              },
              itemCount: result.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
