import 'package:bloc/bloc.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc(
    this.searchMovies,
  ) : super(SearchMovieEmpty()) {
    on<OnQueryMovieChanged>(
      _onQueryChanged,
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }

  final SearchMovies searchMovies;

  void _onQueryChanged(
    OnQueryMovieChanged event,
    Emitter<SearchMovieState> emit,
  ) async {
    emit(SearchMovieLoading());

    final result = await searchMovies.execute(event.query);

    result.fold(
      (failure) {
        emit(SearchMovieError(failure.message));
      },
      (success) {
        emit(SearchMovieHasResult(success));
      },
    );
  }
}
