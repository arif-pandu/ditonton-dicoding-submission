part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnLoadMovieWatchlist extends MovieWatchlistEvent {
  final int id;

  OnLoadMovieWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnAddMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnRemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
