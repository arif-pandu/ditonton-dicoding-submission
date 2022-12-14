import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeries = TVSeriesModel(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );

  final tTvSeriesResponseModel = TvSeriesResponse(tvSeriesList: <TVSeriesModel>[tTvSeries]);

  group(
    "fromJson",
    () {
      test(
        "should return a valid model from JSON",
        () async {
          /// Arrange
          final Map<String, dynamic> jsonMap = json.decode(readJson("dummy_data/now_playing_tv_series.json"));

          /// Act
          final result = TvSeriesResponse.fromJson(jsonMap);

          /// Assert
          expect(result, tTvSeriesResponseModel);
        },
      );
    },
  );

  group(
    "toJson",
    () {
      test(
        "should return a JSON map containing proper data",
        () async {
          /// Arrange
          final expectedJsonMap = {
            "results": [
              {
                "poster_path": "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
                "popularity": 47.432451,
                "id": 31917,
                "backdrop_path": "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
                "vote_average": 5.04,
                "overview":
                    "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
                "origin_country": ["US"],
                "genre_ids": [18, 9648],
                "original_language": "en",
                "vote_count": 133,
                "name": "Pretty Little Liars",
                "original_name": "Pretty Little Liars"
              }
            ],
          };

          /// Act
          final result = tTvSeriesResponseModel.toJson();

          /// Assert

          expect(result, expectedJsonMap);
        },
      );
    },
  );
}
