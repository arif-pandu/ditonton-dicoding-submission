import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = "/top-rated-tv";

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TopRatedTvSeriesNotifier>(context, listen: false).fetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Rated Tv Series"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<TopRatedTvSeriesNotifier>(
          builder: (context, data, _) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: data.tvSeries.length,
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeries[index];
                  return CardThumbnail(
                    ContentCategory.TvSeries,
                    tvSeries.id,
                    tvSeries.posterPath,
                    tvSeries.name,
                    tvSeries.overview,
                  );
                },
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
