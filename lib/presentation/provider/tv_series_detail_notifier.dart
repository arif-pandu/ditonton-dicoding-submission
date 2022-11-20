import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = "";
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationState = RequestState.Loading;
        _tvSeries = tvSeries;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (recommendTvSeries) {
            _recommendationState = RequestState.Loaded;
            _tvSeriesRecommendations = recommendTvSeries;
          },
        );
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchListMessage = "";
  String get watchListMessage => _watchListMessage;

  Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveWatchlist.executeTvSeries(tvSeries);

    await result.fold(
      (failure) async {
        _watchListMessage = failure.message;
      },
      (successMessage) async {
        _watchListMessage = successMessage;
      },
    );
    await loadWatchListStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeWatchlist.executeTvSeries(tvSeries);

    await result.fold(
      (failure) async {
        _watchListMessage = failure.message;
      },
      (successMessage) async {
        _watchListMessage = successMessage;
      },
    );

    await loadWatchListStatus(tvSeries.id);
  }

  Future<void> loadWatchListStatus(int id) async {
    final result = await getWatchListStatus.executeTvSeries(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
