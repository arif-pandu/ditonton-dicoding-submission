// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
// import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'popular_tv_series_notifier_test.mocks.dart';

// @GenerateMocks([
//   GetPopularTvSeries,
// ])
// void main() {
//   late MockGetPopularTvSeries mockGetPopularTvSeries;
//   late PopularTvSeriesNotifier notifier;
//   late int listenerCalCount;

//   setUp(() {
//     listenerCalCount = 0;
//     mockGetPopularTvSeries = MockGetPopularTvSeries();
//     notifier = PopularTvSeriesNotifier(mockGetPopularTvSeries)
//       ..addListener(() {
//         listenerCalCount++;
//       });
//   });

//   final tTvSeries = TvSeries(
//     posterPath: "posterPath",
//     popularity: 1.0,
//     id: 1,
//     backdropPath: "backdropPath",
//     voteAverage: 1.0,
//     overview: "overview",
//     originCountry: ["originCountry"],
//     genreIds: [1],
//     originalLanguage: "originalLanguage",
//     voteCount: 1,
//     name: "name",
//     originalName: "originalName",
//   );

//   final tTvSeriesList = <TvSeries>[tTvSeries];

//   test(
//     "should change state to Loading when usecase is called",
//     () async {
//       /// Arrange
//       when(mockGetPopularTvSeries.execute()).thenAnswer(
//         (_) async => Right(tTvSeriesList),
//       );

//       /// Act
//       notifier.fetchPopularTvSeries();

//       /// Assert
//       expect(notifier.state, RequestState.Loading);
//       expect(listenerCalCount, 1);
//     },
//   );

//   test(
//     "should change tv series data when data is gottensuccesssfully",
//     () async {
//       /// Arrange
//       when(mockGetPopularTvSeries.execute()).thenAnswer(
//         (_) async => Right(tTvSeriesList),
//       );

//       /// Act
//       await notifier.fetchPopularTvSeries();

//       /// Assert
//       expect(notifier.state, RequestState.Loaded);
//       expect(notifier.tvSeries, tTvSeriesList);
//       expect(listenerCalCount, 2);
//     },
//   );

//   test(
//     "should return error when data is not success",
//     () async {
//       /// Arrange
//       when(mockGetPopularTvSeries.execute()).thenAnswer(
//         (_) async => Left(ServerFailure("Server Failure")),
//       );

//       /// Act
//       await notifier.fetchPopularTvSeries();

//       /// Assert
//       expect(notifier.state, RequestState.Error);
//       expect(notifier.message, "Server Failure");
//       expect(listenerCalCount, 2);
//     },
//   );
// }
