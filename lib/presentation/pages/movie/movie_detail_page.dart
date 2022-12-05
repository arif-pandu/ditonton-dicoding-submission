import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/detail_page/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(OnFetchMovieDetail(widget.id));
    context.read<MovieWatchlistBloc>().add(OnLoadMovieWatchlist(widget.id));
    context.read<MovieRecommendationBloc>().add(OnFetchMovieRecommendation(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailInitial || state is MovieDetailFetchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailFetchSuccess) {
            final movie = state.movie;

            return SafeArea(
              child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, states) {
                  if (states is MovieWatchlistStatus) {
                    return _buildDetailContent(
                      movie,
                      states.status,
                      context,
                    );
                  } else if (states is MovieWatchlistAddSuccess) {
                    return _buildDetailContent(
                      movie,
                      true,
                      context,
                    );
                  } else if (states is MovieWatchlistRemoveSuccess) {
                    return _buildDetailContent(
                      movie,
                      false,
                      context,
                    );
                  } else if (states is MovieWatchlistAddFailed) {
                    return _buildDetailContent(
                      movie,
                      false,
                      context,
                    );
                  } else if (states is MovieWatchlistRemoveFailed) {
                    return _buildDetailContent(
                      movie,
                      true,
                      context,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          } else if (state is MovieDetailFetchFailed) {
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

  DetailContent _buildDetailContent(
    MovieDetail movie,
    bool isAddedToWatchlist,
    BuildContext context,
  ) {
    return DetailContent(
      contentCategory: ContentCategory.Film,
      id: movie.id,
      name: movie.title,
      imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
      isAddedToWatchlist: isAddedToWatchlist,
      onTapWatchlist: () {
        if (isAddedToWatchlist) {
          context.read<MovieWatchlistBloc>().add(OnRemoveMovieWatchlist(movie));
          print("Remove");
        } else {
          context.read<MovieWatchlistBloc>().add(OnAddMovieWatchlist(movie));
          print("Added");
        }

        if (isAddedToWatchlist) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Removed From Watchlist",
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Added To Watchlist",
              ),
            ),
          );
        }
      },
      genres: movie.genres,
      overview: movie.overview,
      voteAverage: movie.voteAverage,
      runtime: movie.runtime,
    );
  }
}
