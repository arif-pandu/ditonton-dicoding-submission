import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 0;
  final listResult = [_MovieResult(), _TvSeriesResult()];

  @override
  Widget build(BuildContext context) {
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
                  value: _selectedIndex,
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
                    setState(() {
                      _selectedIndex = value!;
                    });
                  },
                ),
              ],
            ),
            listResult[_selectedIndex],
          ],
        ),
      ),
    );
  }
}

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
