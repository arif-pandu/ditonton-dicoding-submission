import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class PopularTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = "/popular-tv";

  @override
  State<PopularTVSeriesPage> createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PopularTvSeriesNotifier>(context, listen: false).fetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Tv Series"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<PopularTvSeriesNotifier>(
          builder: (context, data, _) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeries[index];
                  return CardThumbnail(
                    tvSeries.id!,
                    tvSeries.posterPath,
                    tvSeries.name,
                    tvSeries.overview,
                  );
                },
                itemCount: data.tvSeries.length,
              );
            } else {
              return Center(
                key: Key("erroe_message"),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
