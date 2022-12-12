import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  WatchlistTvSeriesBloc(this.getWathclistTvSeries) : super(WatchlistTvSeriesInitial()) {
    on<OnFetchWatchlistTvSeries>(_onFetchWatchlistTvSeries);
  }

  final GetWathclistTvSeries getWathclistTvSeries;

  void _onFetchWatchlistTvSeries(
    OnFetchWatchlistTvSeries event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    emit(WatchlistTvSeriesLoading());

    final result = await getWathclistTvSeries.excute();

    result.fold(
      (failure) {
        emit(WatchlistTvSeriesError(failure.message));
      },
      (watchlist) {
        emit(WatchlistTvSeriesLoaded(watchlist));
      },
    );
  }
}
