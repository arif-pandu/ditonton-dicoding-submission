import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/detail_page/detail_content.dart';
import 'package:ditonton/presentation/widgets/detail_page/recommendation_movie.dart';
import 'package:ditonton/presentation/widgets/detail_page/show_duration.dart';
import 'package:ditonton/presentation/widgets/detail_page/show_genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(context, listen: false).fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false).loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.movieState == RequestState.Loaded) {
            final movie = provider.movie;
            return SafeArea(
              child: DetailContent(
                contentCategory: ContentCategory.Film,
                name: movie.title,
                imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                isAddedToWatchlist: provider.isAddedToWatchlist,
                onTapWatchlist: () async {
                  if (!provider.isAddedToWatchlist) {
                    await provider.addWatchlist(movie);
                  } else {
                    await provider.removeFromWatchlist(movie);
                  }

                  final message = provider.watchlistMessage;

                  if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
                      message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(message),
                        );
                      },
                    );
                  }
                },
                overview: movie.overview,
                voteAverage: movie.voteAverage,
                genres: movie.genres,
                runtime: movie.runtime,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}
