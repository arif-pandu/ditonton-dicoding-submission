import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  TvSeriesDetailBloc(
    this.getTvSeriesDetail,
  ) : super(TvSeriesDetailInitial()) {
    on<OnFetchTvSeriesDetail>(_onFetchTvSeriesDetail);
  }

  final GetTvSeriesDetail getTvSeriesDetail;

  void _onFetchTvSeriesDetail(
    OnFetchTvSeriesDetail event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    emit(TvSeriesDetailFetchLoading());

    final detailResult = await getTvSeriesDetail.execute(event.id);

    detailResult.fold(
      (failure) {
        emit(TvSeriesDetailFetchFailed(failure.message));
      },
      (tvSeries) {
        emit(TvSeriesDetailFetchSuccess(tvSeries));
      },
    );
  }
}
