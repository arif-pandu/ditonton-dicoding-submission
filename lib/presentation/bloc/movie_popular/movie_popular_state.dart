part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularInitial extends MoviePopularState {}

class MoviePopularLoading extends MoviePopularState {}

class MoviePopularLoaded extends MoviePopularState {
  final List<Movie> popularMovie;

  MoviePopularLoaded(this.popularMovie);

  @override
  List<Object> get props => [popularMovie];
}

class MoviePopularError extends MoviePopularState {
  final String message;

  MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}
