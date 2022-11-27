import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = "/now-playing-tv";

  @override
  State<NowPlayingTVSeriesPage> createState() => _NowPlayingTVSeriesPageState();
}

class _NowPlayingTVSeriesPageState extends State<NowPlayingTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvSeriesListNotifier>(context, listen: false).fetchNowPlayingTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tv Series Airing Today"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<TvSeriesListNotifier>(
          builder: (context, data, _) {
            if (data.nowPlayingState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.nowPlayingState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.nowPlayingTvSeries[index];
                  return CardThumbnail(
                    ContentCategory.TvSeries,
                    tvSeries.id,
                    tvSeries.posterPath,
                    tvSeries.name,
                    tvSeries.overview,
                  );
                },
                itemCount: data.nowPlayingTvSeries.length,
              );
            } else {
              return Center(
                key: Key("error_message"),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
