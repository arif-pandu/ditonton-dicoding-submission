import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  MoviePopularBloc(
    this.getPopularMovies,
  ) : super(MoviePopularInitial()) {
    on<OnFetchMoviePopular>(_onFetchMoviePopular);
  }

  final GetPopularMovies getPopularMovies;

  void _onFetchMoviePopular(
    OnFetchMoviePopular event,
    Emitter<MoviePopularState> emit,
  ) async {
    emit(MoviePopularLoading());

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(MoviePopularError(failure.message));
      },
      (popular) {
        emit(MoviePopularLoaded(popular));
      },
    );
  }
}
