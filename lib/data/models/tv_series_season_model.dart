import 'package:ditonton/domain/entities/tv_series_season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json["airDate"],
        episodeCount: json["episodeCount"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["posterPath"],
        seasonNumber: json["seasonNumber"],
      );

  Map<String, dynamic> toJson() => {
        "airDate": airDate,
        "episodeCount": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "posterPath": posterPath,
        "seasonNumber": seasonNumber,
      };

  Season toEntity() {
    return Season(
      airDate: airDate,
      episodeCount: episodeCount,
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
