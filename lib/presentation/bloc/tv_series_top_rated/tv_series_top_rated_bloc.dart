import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  TvSeriesTopRatedBloc(
    this.getTopRatedTvSeries,
  ) : super(TvSeriesTopRatedInitial()) {
    on<OnFetchTvSeriesTopRated>(_onFetchTvSeriesTopRated);
  }

  final GetTopRatedTvSeries getTopRatedTvSeries;

  void _onFetchTvSeriesTopRated(
    OnFetchTvSeriesTopRated event,
    Emitter<TvSeriesTopRatedState> emit,
  ) async {
    emit(TvSeriesTopRatedLoading());

    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        emit(TvSeriesTopRatedError(failure.message));
      },
      (topRated) {
        emit(TvSeriesTopRatedLoaded(topRated));
      },
    );
  }
}
