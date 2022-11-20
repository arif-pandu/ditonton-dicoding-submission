import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter/material.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  var _watchlistTvSeries = <TvSeries>[];

  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  RequestState _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = "";
  String get message => _message;

  WatchlistTvSeriesNotifier({required this.getWathclistTvSeries});

  final GetWathclistTvSeries getWathclistTvSeries;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWathclistTvSeries.excute();
    result.fold(
      (failure) {
        _message = failure.message;
        _watchlistState = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
