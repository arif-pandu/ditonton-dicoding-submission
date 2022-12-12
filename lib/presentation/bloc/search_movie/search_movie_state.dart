part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieEmpty extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieHasResult extends SearchMovieState {
  final List<Movie> movieResult;

  SearchMovieHasResult(this.movieResult);

  @override
  List<Object> get props => [movieResult];
}

class SearchMovieError extends SearchMovieState {
  final String message;

  SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}
