part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchlistStatus extends MovieWatchlistState {
  final bool status;

  MovieWatchlistStatus(this.status);
  @override
  List<Object> get props => [status];
}

class MovieWatchlistAddSuccess extends MovieWatchlistState {
  final String message;

  MovieWatchlistAddSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistAddFailed extends MovieWatchlistState {
  final String message;

  MovieWatchlistAddFailed(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistRemoveSuccess extends MovieWatchlistState {
  final String message;

  MovieWatchlistRemoveSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistRemoveFailed extends MovieWatchlistState {
  final String message;

  MovieWatchlistRemoveFailed(this.message);

  @override
  List<Object> get props => [message];
}
