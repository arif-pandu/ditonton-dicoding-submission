import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  TvSeriesWatchlistBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(TvSeriesWatchlistInitial()) {
    on<OnLoadTvSeriesWatchlist>(_onLoadWatchlist);
    on<OnAddTvSeriesWatchlist>(_onAddWatchlist);
    on<OnRemoveTvSeriesWatchlist>(_onRemovedWatchlist);
  }

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  void _onLoadWatchlist(
    OnLoadTvSeriesWatchlist event,
    Emitter<TvSeriesWatchlistState> emit,
  ) async {
    final result = await getWatchListStatus.executeTvSeries(event.id);

    emit(TvSeriesWatchlistStatus(result));
  }

  void _onAddWatchlist(
    OnAddTvSeriesWatchlist event,
    Emitter<TvSeriesWatchlistState> emit,
  ) async {
    final result = await saveWatchlist.executeTvSeries(event.tvSeriesDetail);

    result.fold(
      (failure) {
        emit(TvSeriesWatchlistAddFailed(failure.message));
      },
      (successMsg) {
        emit(TvSeriesWatchlistAddSuccess(successMsg));
      },
    );
  }

  void _onRemovedWatchlist(
    OnRemoveTvSeriesWatchlist event,
    Emitter<TvSeriesWatchlistState> emit,
  ) async {
    final result = await removeWatchlist.executeTvSeries(event.tvSeriesDetail);

    result.fold(
      (failure) {
        emit(TvSeriesWatchlistRemoveFailed(failure.message));
      },
      (successMsg) {
        emit(TvSeriesWatchlistRemoveSuccess(successMsg));
      },
    );
  }
}
