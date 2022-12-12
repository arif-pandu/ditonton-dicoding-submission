import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  WatchlistMovieBloc(
    this.getWatchlistMovies,
  ) : super(WatchlistMovieInitial()) {
    on<OnFetchWatchlistMovie>(_onFetchWatchlistMovie);
  }

  final GetWatchlistMovies getWatchlistMovies;

  void _onFetchWatchlistMovie(
    OnFetchWatchlistMovie event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(WatchlistMovieLoading());

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistMovieError(failure.message));
      },
      (watchlist) {
        emit(WatchlistMovieLoaded(watchlist));
      },
    );
  }
}
