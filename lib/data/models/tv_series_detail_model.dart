import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<Season> seasons;
  final String status;
  final double voteAverage;
  final int voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) => TvSeriesDetailResponse(
        backdropPath: json["backdropPath"],
        firstAirDate: json["firstAirDate"],
        genres: json["genres"],
        id: json["id"],
        inProduction: json["inProduction"],
        languages: json["languages"],
        name: json["name"],
        numberOfEpisodes: json["numberOfEpisodes"],
        numberOfSeasons: json["numberOfSeasons"],
        originCountry: json["originCountry"],
        originalLanguage: json["originalLanguage"],
        originalName: json["originalName"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["posterPath"],
        seasons: json["seasons"],
        status: json["status"],
        voteAverage: json["voteAverage"],
        voteCount: json['voteCount'],
      );

  Map<String, dynamic> toJson() => {
        "backdropPath": backdropPath,
        "firstAirDate": firstAirDate,
        "genres": genres,
        "id": id,
        "inProduction": inProduction,
        "languages": languages,
        "name": name,
        "numberOfEpisodes": numberOfEpisodes,
        "numberOfSeasons": numberOfSeasons,
        "originCountry": originCountry,
        "originalLanguage": originalLanguage,
        "originalName": originalName,
        "overview": overview,
        "popularity": popularity,
        "posterPath": posterPath,
        "seasons": seasons,
        "status": status,
        "voteAverage": voteAverage,
        "voteCount": voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      seasons: this.seasons,
      status: this.status,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        inProduction,
        languages,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        voteAverage,
        voteCount,
      ];
}
