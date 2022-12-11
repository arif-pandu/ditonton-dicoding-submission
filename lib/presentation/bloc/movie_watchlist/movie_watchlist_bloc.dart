import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  MovieWatchlistBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieWatchlistInitial()) {
    on<OnLoadMovieWatchlist>(_onLoadWatchlist);
    on<OnAddMovieWatchlist>(_onAddWatchlist);
    on<OnRemoveMovieWatchlist>(_onRemoveWatchlist);
  }

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  void _onLoadWatchlist(
    OnLoadMovieWatchlist event,
    Emitter<MovieWatchlistState> emit,
  ) async {
    final result = await getWatchListStatus.executeMovie(event.id);

    emit(MovieWatchlistStatus(result));
  }

  void _onAddWatchlist(
    OnAddMovieWatchlist event,
    Emitter<MovieWatchlistState> emit,
  ) async {
    final result = await saveWatchlist.executeMovie(event.movieDetail);

    result.fold(
      (failure) {
        emit(MovieWatchlistAddFailed(failure.message));
      },
      (successMsg) {
        emit(MovieWatchlistAddSuccess(successMsg));
      },
    );
  }

  void _onRemoveWatchlist(
    OnRemoveMovieWatchlist event,
    Emitter<MovieWatchlistState> emit,
  ) async {
    final result = await removeWatchlist.executeMovie(event.movieDetail);

    result.fold(
      (failure) {
        emit(MovieWatchlistRemoveFailed(failure.message));
      },
      (successMsg) {
        emit(MovieWatchlistRemoveSuccess(successMsg));
      },
    );
  }
}
