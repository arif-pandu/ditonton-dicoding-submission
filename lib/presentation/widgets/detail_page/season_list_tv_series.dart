import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter/material.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({
    Key? key,
    required this.listSeason,
  }) : super(key: key);

  final List<Season> listSeason;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listSeason.length,
        itemBuilder: (context, index) {
          final season = listSeason[index];
          return Padding(
            padding: EdgeInsets.all(4),
            child: InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
