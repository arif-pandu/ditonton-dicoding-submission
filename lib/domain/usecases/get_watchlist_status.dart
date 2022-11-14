import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchListStatus {
  final MovieRepository movieRepository;
  final TVSeriesRepository tvSeriesRepository;

  GetWatchListStatus(
    this.movieRepository,
    this.tvSeriesRepository,
  );

  Future<bool> executeMovie(int id) async {
    return movieRepository.isAddedToWatchlist(id);
  }

  Future<bool> executeTvSeries(int id) async {
    return tvSeriesRepository.isAddedToWatchlist(id);
  }
}
