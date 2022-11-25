import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/detail_page/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = "/detail-tv";

  final int id;
  const TvSeriesDetailPage({required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false).fetchTvSeriesDetail(widget.id);
      Provider.of<TvSeriesDetailNotifier>(context, listen: false).loadWatchListStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, _) {
          if (provider.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.Loaded) {
            final tvSeries = provider.tvSeries;
            return SafeArea(
              child: DetailContent(
                contentCategory: ContentCategory.TvSeries,
                imageUrl: "https://image.tmdb.org/t/p/w500${tvSeries.posterPath}",
                isAddedToWatchlist: provider.isAddedToWatchlist,
                onTapWatchlist: () async {},
                overview: tvSeries.overview,
                voteAverage: tvSeries.voteAverage,
                genres: tvSeries.genres,
                numOfSeasons: tvSeries.numberOfSeasons,
                numOfEps: tvSeries.numberOfEpisodes,
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
