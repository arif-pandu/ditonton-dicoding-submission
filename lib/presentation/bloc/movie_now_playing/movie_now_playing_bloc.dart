import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  MovieNowPlayingBloc(
    this.getNowPlayingMovies,
  ) : super(MovieNowPlayingInitial()) {
    on<OnFetchMovieNowPlaying>(_onFetchMovieNowPlaying);
  }
  final GetNowPlayingMovies getNowPlayingMovies;

  void _onFetchMovieNowPlaying(
    OnFetchMovieNowPlaying event,
    Emitter<MovieNowPlayingState> emit,
  ) async {
    emit(MovieNowPlayingLoading());
    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(MovieNowPlayingError(failure.message));
      },
      (nowPlaying) {
        emit(MovieNowPlayingLoaded(nowPlaying));
      },
    );
  }
}
