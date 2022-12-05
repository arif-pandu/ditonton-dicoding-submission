import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/presentation/widgets/detail_page/recommendation_movie.dart';
import 'package:ditonton/presentation/widgets/detail_page/recommendation_tv_series.dart';
import 'package:ditonton/presentation/widgets/detail_page/season_list_tv_series.dart';
import 'package:ditonton/presentation/widgets/detail_page/show_duration.dart';
import 'package:ditonton/presentation/widgets/detail_page/show_genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
    required this.contentCategory,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isAddedToWatchlist,
    required this.onTapWatchlist,
    required this.genres,
    required this.overview,
    required this.voteAverage,
    this.runtime,
    this.numOfSeasons,
    this.numOfEps,
    this.seasonList,
  });

  final ContentCategory contentCategory;
  final int id;
  final String name;
  final String? imageUrl;
  final bool isAddedToWatchlist;
  final void Function() onTapWatchlist;
  final List<Genre> genres;
  final String overview;
  final double voteAverage;

  final int? runtime;
  final int? numOfSeasons;
  final int? numOfEps;
  final List<Season>? seasonList;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        () {
          if (imageUrl == null) {
            return Container(
              color: Colors.white,
              child: Center(child: Text("NO Image")),
            );
          } else {
            return CachedNetworkImage(
              imageUrl: imageUrl!,
              width: screenWidth,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          }
        }(),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: kHeading5,
                            ),
                            Text(showGenres(genres)),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: onTapWatchlist,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedToWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                                      Text("Watchlist"),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                RatingBarIndicator(
                                  rating: voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Icon(
                                      Icons.star_rounded,
                                      color: kMikadoYellow,
                                    );
                                  },
                                  itemSize: 24,
                                ),
                                Text(voteAverage.toStringAsFixed(1)),
                                SizedBox(width: 20),
                              ],
                            ),
                            () {
                              if (contentCategory == ContentCategory.Film) {
                                return Text(showDuration(runtime!));
                              } else {
                                return Text("$numOfSeasons Season, $numOfEps Eps");
                              }
                            }(),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              overview,
                            ),
                            SizedBox(height: 16),
                            () {
                              if (contentCategory == ContentCategory.TvSeries) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Seasons',
                                      style: kHeading6,
                                    ),
                                    SeasonList(listSeason: seasonList!),
                                  ],
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }(),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            () {
                              if (contentCategory == ContentCategory.Film) {
                                return RecommendationMovieList(
                                  id: id,
                                );
                              } else {
                                return RecommendationTvSeriesList();
                              }
                            }(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 4,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
