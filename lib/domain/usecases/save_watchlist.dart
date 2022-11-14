import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SaveWatchlist {
  final MovieRepository movieRepository;
  final TVSeriesRepository tvSeriesRepository;

  SaveWatchlist(this.movieRepository, this.tvSeriesRepository);

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return movieRepository.saveWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTvSeries(TvSeriesDetail tvSeries) {
    return tvSeriesRepository.saveWatchlist(tvSeries);
  }
}
