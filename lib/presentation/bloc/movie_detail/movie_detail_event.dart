part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;

  OnFetchMovieDetail(this.id);
  List<Object> get props => [id];
}
