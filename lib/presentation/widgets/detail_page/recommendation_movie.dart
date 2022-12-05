import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationMovieList extends StatelessWidget {
  RecommendationMovieList({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
      buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is MovieRecommendationInitial || state is MovieRecommendationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieRecommendationLoaded) {
          return Container(
            height: 150,
            child: () {
              if (state.results.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    final movie = state.results[index];
                    return Padding(
                      padding: EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            MovieDetailPage.ROUTE_NAME,
                            arguments: movie.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                );
              } else {
                return Center(
                  child: Text(
                    "No Recommendation",
                    style: kSubtitle,
                  ),
                );
              }
            }(),
          );
        } else {
          return Center(
            child: Icon(Icons.error),
          );
        }
      },
    );
  }
}
