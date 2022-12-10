import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  MovieTopRatedBloc(
    this.getTopRatedMovies,
  ) : super(MovieTopRatedInitial()) {
    on<OnFetchMovieTopRated>(_onFetchMovieTopRated);
  }

  final GetTopRatedMovies getTopRatedMovies;

  void _onFetchMovieTopRated(
    OnFetchMovieTopRated event,
    Emitter<MovieTopRatedState> emit,
  ) async {
    emit(MovieTopRatedLoading());

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(MovieTopRatedError(failure.message));
      },
      (topRated) {
        emit(MovieTopRatedLoaded(topRated));
      },
    );
  }
}
