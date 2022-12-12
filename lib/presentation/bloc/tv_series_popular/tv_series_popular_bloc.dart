import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  TvSeriesPopularBloc(
    this.getPopularTvSeries,
  ) : super(TvSeriesPopularInitial()) {
    on<OnFetchTvSeriesPopular>(_onFetchTvSeriesPopular);
  }

  final GetPopularTvSeries getPopularTvSeries;

  void _onFetchTvSeriesPopular(
    OnFetchTvSeriesPopular event,
    Emitter<TvSeriesPopularState> emit,
  ) async {
    emit(TvSeriesPopularLoading());

    final result = await getPopularTvSeries.execute();

    result.fold(
      (failure) {
        emit(TvSeriesPopularError(failure.message));
      },
      (popular) {
        emit(TvSeriesPopularLoaded(popular));
      },
    );
  }
}
