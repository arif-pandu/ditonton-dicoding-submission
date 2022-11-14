import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TVSeriesModel> tvSeriesList;

  TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) => TvSeriesResponse(
        tvSeriesList: List<TVSeriesModel>.from(
          (json["results"] as List).map((x) => TVSeriesModel.fromJson(x)).where((element) => element.posterPath != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvSeriesList];
}
