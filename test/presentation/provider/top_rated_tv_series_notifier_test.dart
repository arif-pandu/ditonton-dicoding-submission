// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
// import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'top_rated_tv_series_notifier_test.mocks.dart';

// @GenerateMocks([
//   GetTopRatedTvSeries,
// ])
// void main() {
//   late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
//   late TopRatedTvSeriesNotifier notifier;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
//     notifier = TopRatedTvSeriesNotifier(getTopRatedTvSeries: mockGetTopRatedTvSeries)
//       ..addListener(() {
//         listenerCallCount++;
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
//     "should change state to loading when usecase is called",
//     () async {
//       /// Arrange
//       when(mockGetTopRatedTvSeries.execute()).thenAnswer(
//         (_) async => Right(tTvSeriesList),
//       );

//       /// Act
//       notifier.fetchTopRatedTvSeries();

//       /// Assert
//       expect(notifier.state, RequestState.Loading);
//       expect(listenerCallCount, 1);
//     },
//   );

//   test(
//     "should change tv series data when data is gotten successfully",
//     () async {
//       /// Arrange
//       when(mockGetTopRatedTvSeries.execute()).thenAnswer(
//         (_) async => Right(tTvSeriesList),
//       );

//       /// Act
//       await notifier.fetchTopRatedTvSeries();

//       /// Assert
//       expect(notifier.state, RequestState.Loaded);
//       expect(notifier.tvSeries, tTvSeriesList);
//       expect(listenerCallCount, 2);
//     },
//   );

//   test(
//     "should return error when data is not success",
//     () async {
//       /// Arrange
//       when(mockGetTopRatedTvSeries.execute()).thenAnswer(
//         (_) async => Left(ServerFailure("Server Failure")),
//       );

//       /// Act
//       await notifier.fetchTopRatedTvSeries();

//       /// Assert
//       expect(notifier.state, RequestState.Error);
//       expect(notifier.message, "Server Failure");
//       expect(listenerCallCount, 2);
//     },
//   );
// }
