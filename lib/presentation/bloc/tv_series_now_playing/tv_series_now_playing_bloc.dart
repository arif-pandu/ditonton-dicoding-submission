import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_now_playing_event.dart';
part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  TvSeriesNowPlayingBloc(
    this.getNowPlayingTvSeries,
  ) : super(TvSeriesNowPlayingInitial()) {
    on<OnFetchTvSeriesNowPlaying>(_onFetchTvSeriesNowPlaying);
  }

  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  void _onFetchTvSeriesNowPlaying(
    OnFetchTvSeriesNowPlaying event,
    Emitter<TvSeriesNowPlayingState> emit,
  ) async {
    emit(TvSeriesNowPlayingLoading());

    final result = await getNowPlayingTvSeries.execute();

    result.fold(
      (failure) {
        emit(TvSeriesNowPlayingError(failure.message));
      },
      (nowPlaying) {
        emit(TvSeriesNowPlayingLoaded(nowPlaying));
      },
    );
  }
}
