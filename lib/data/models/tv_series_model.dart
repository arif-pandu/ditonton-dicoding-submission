import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TVSeriesModel extends Equatable {
  TVSeriesModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
        posterPath: json["posterPath"],
        popularity: json["popularity"],
        id: json["id"],
        backdropPath: json["backdropPath"],
        voteAverage: json["voteAverage"],
        overview: json["overview"],
        firstAirDate: json["firstAirDate"],
        originCountry: json["originCountry"],
        genreIds: json["genreIds"],
        originalLanguage: json["originalLanguage"],
        voteCount: json["voteCount"],
        name: json["name"],
        originalName: json["originalName"],
      );

  Map<String, dynamic> toJson() => {
        "posterPath": posterPath,
        "popularity": popularity,
        "id": id,
        "backdropPath": backdropPath,
        "voteAverage": voteAverage,
        "overview": overview,
        "firstAirDate": firstAirDate,
        "originCountry": originCountry,
        "genreIds": genreIds,
        "originalLanguage": originalLanguage,
        "voteCount": voteCount,
        "name": name,
        "originalName": originalName,
      };

  TVSeries toEntitiy() {
    return TVSeries(
      posterPath: this.posterPath,
      popularity: this.popularity,
      id: this.id,
      backdropPath: this.backdropPath,
      voteAverage: this.voteAverage,
      overview: this.overview,
      firstAirDate: this.firstAirDate,
      originCountry: this.originCountry,
      genreIds: this.genreIds,
      originalLanguage: this.originalLanguage,
      voteCount: this.voteCount,
      name: this.name,
      originalName: this.originalName,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
