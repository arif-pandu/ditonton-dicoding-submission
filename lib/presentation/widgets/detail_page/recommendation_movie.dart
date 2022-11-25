import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendationMovieList extends StatelessWidget {
  const RecommendationMovieList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendationState == RequestState.Error) {
          return Text(data.message);
        } else if (data.recommendationState == RequestState.Loaded) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = data.movieRecommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: data.movieRecommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
