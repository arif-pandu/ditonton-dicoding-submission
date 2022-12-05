part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailFetchLoading extends MovieDetailState {}

class MovieDetailFetchSuccess extends MovieDetailState {
  final MovieDetail movie;
  final bool isAddedToWatchlist;

  MovieDetailFetchSuccess(this.movie, this.isAddedToWatchlist);

  @override
  List<Object> get props => [movie, isAddedToWatchlist];
}

class MovieDetailFetchFailed extends MovieDetailState {
  final String message;

  MovieDetailFetchFailed(this.message);

  @override
  List<Object> get props => [message];
}
