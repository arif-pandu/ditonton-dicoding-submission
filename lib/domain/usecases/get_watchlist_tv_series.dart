import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWathclistTvSeries {
  final TVSeriesRepository _repository;

  GetWathclistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> excute() {
    return _repository.getWatchlistTvSeries();
  }
}
