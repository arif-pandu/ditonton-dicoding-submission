import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TVSeriesModel(
    posterPath: "posterPath",
    popularity: 1.0,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1.0,
    overview: "overview",
    firstAirDate: "firstAirDate",
    originCountry: ["originCountry"],
    genreIds: [1],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName",
  );

  final tTvSeries = TvSeries(
    posterPath: "posterPath",
    popularity: 1.0,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1.0,
    overview: "overview",
    firstAirDate: "firstAirDate",
    originCountry: ["originCountry"],
    genreIds: [1],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName",
  );

  test(
    "should be a subclass of TvSeries entity",
    () async {
      final result = tTvSeriesModel.toEntitiy();
      expect(result, tTvSeries);
    },
  );
}
