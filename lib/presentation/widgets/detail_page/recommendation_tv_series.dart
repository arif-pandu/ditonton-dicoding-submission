import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RecommendationTvSeriesList extends StatelessWidget {
  const RecommendationTvSeriesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      builder: (context, state) {
        if (state is TvSeriesRecommendationInitial || state is TvSeriesRecommendationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSeriesRecommendationLoaded) {
          return Container(
            height: 150,
            child: () {
              if (state.results.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    final tvSeries = state.results[index];
                    return Padding(
                      padding: EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            TvSeriesDetailPage.ROUTE_NAME,
                            arguments: tvSeries.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
