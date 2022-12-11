import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(
    this.getMovieDetail,
  ) : super(MovieDetailInitial()) {
    on<OnFetchMovieDetail>(_onFetchMovieDetail);
  }
  final GetMovieDetail getMovieDetail;

  void _onFetchMovieDetail(
    OnFetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailFetchLoading());

    final detailResult = await getMovieDetail.execute(event.id);

    detailResult.fold(
      (failure) {
        emit(MovieDetailFetchFailed(failure.message));
      },
      (movie) {
        emit(MovieDetailFetchSuccess(movie));
      },
    );
  }
}
