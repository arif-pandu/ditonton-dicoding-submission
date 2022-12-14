// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
// import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
// import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
// import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'tv_series_list_notifier_test.mocks.dart';

// @GenerateMocks([
//   GetNowPlayingTvSeries,
//   GetPopularTvSeries,
//   GetTopRatedTvSeries,
// ])
// void main() {
//   late TvSeriesListNotifier provider;
//   late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
//   late MockGetPopularTvSeries mockGetPopularTvSeries;
//   late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
//     mockGetPopularTvSeries = MockGetPopularTvSeries();
//     mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
//     provider = TvSeriesListNotifier(
//       getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
//       getPopularTvSeries: mockGetPopularTvSeries,
//       getTopRatedTvSeries: mockGetTopRatedTvSeries,
//     )..addListener(() {
//         listenerCallCount += 1;
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

//   group(
//     "now playing tv series",
//     () {
//       test(
//         "initialState should be empty",
//         () {
//           expect(provider.nowPlayingState, equals(RequestState.Empty));
//         },
//       );

//       test(
//         "should get data from the usecase",
//         () async {
//           /// Arrannge
//           when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
//             (_) async => Right(tTvSeriesList),
//           );

//           /// Act
//           provider.fetchNowPlayingTvSeries();

//           ///Assert
//           verify(mockGetNowPlayingTvSeries.execute());
//         },
//       );

//       test(
//         "should change state to Loading when usecase is called",
//         () {
//           /// Arrange
//           when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
//             (_) async => Right(tTvSeriesList),
//           );

//           /// Act
//           provider.fetchNowPlayingTvSeries();

//           /// Assert
//           expect(provider.nowPlayingState, RequestState.Loading);
//         },
//       );

//       test(
//         "should change tv series when data is gotten successfully",
//         () async {
//           /// Arrange
//           when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
//             (_) async => Right(tTvSeriesList),
//           );

//           /// Act
//           await provider.fetchNowPlayingTvSeries();

//           /// Assert
//           expect(provider.nowPlayingState, RequestState.Loaded);
//           expect(provider.nowPlayingTvSeries, tTvSeriesList);
//           expect(listenerCallCount, 2);
//         },
//       );

//       test(
//         "should return error when data is not success",
//         () async {
//           /// Arrange
//           when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
//             (_) async => Left(ServerFailure("Server Failure")),
//           );

//           /// Act
//           await provider.fetchNowPlayingTvSeries();

//           /// Assert
//           expect(provider.nowPlayingState, RequestState.Error);
//           expect(provider.message, "Server Failure");
//           expect(listenerCallCount, 2);
//         },
//       );
//     },
//   );

//   group(
//     "popular tv series",
//     () {
//       test(
//         'should change state to Loading when usecase is called',
//         () async {
//           /// Arrange
//           when(mockGetPopularTvSeries.execute()).thenAnswer(
//             (_) async => Right(tTvSeriesList),
//           );

//           /// Act
//           provider.fetchPopularTvSeries();

//           /// Assert
//           expect(provider.populartvSeriesState, RequestState.Loading);
//         },
//       );

//       test(
//         "should change tv series data when data is gotten successfully",
//         () async {
//           /// Arrange
//           when(mockGetPopularTvSeries.execute()).thenAnswer(
//             (_) async => Right(tTvSeriesList),
//           );

//           /// Act
//           await provider.fetchPopularTvSeries();

//           /// Assert
//           expect(provider.populartvSeriesState, RequestState.Loaded);
//           expect(provider.popularTvSeries, tTvSeriesList);
//           expect(listenerCallCount, 2);
//         },
//       );

//       test(
//         "should return error when data is not success",
//         () async {
//           /// Arrange
//           when(mockGetPopularTvSeries.execute()).thenAnswer(
//             (_) async => Left(ServerFailure("Server Failure")),
//           );

//           /// Act
//           await provider.fetchPopularTvSeries();

//           /// Assert
//           expect(provider.populartvSeriesState, RequestState.Error);
//           expect(provider.message, "Server Failure");
//           expect(listenerCallCount, 2);
//         },
//       );
//     },
//   );

//   group(
//     "top rated tv series",
//     () {
//       test(
//         "should change state to loading when usecase is called",
//         () async {
//           /// Arrange
//           when(mockGetTopRatedTvSeries.execute()).thenAnswer(
//             (_) async => Right(tTvSeriesList),
//           );

//           /// Act
//           provider.fetchTopRatedTvSeries();

//           /// Assert
//           expect(provider.topRatedTvSeriesState, RequestState.Loading);
//         },
//       );

//       test(
//         "should change tv series data when data is gotten successfully",
//         () async {
//           /// Arrange
//           when(mockGetTopRatedTvSeries.execute()).thenAnswer(
//             (_) async => Right(tTvSeriesList),
//           );

//           /// Act
//           await provider.fetchTopRatedTvSeries();

//           /// Assert
//           expect(provider.topRatedTvSeriesState, RequestState.Loaded);
//           expect(provider.topRatedTvSeries, tTvSeriesList);
//           expect(listenerCallCount, 2);
//         },
//       );

//       test(
//         "should return erroe when data is not success",
//         () async {
//           /// Arrange
//           when(mockGetTopRatedTvSeries.execute()).thenAnswer(
//             (_) async => Left(ServerFailure("Server Failure")),
//           );

//           /// Act
//           await provider.fetchTopRatedTvSeries();

//           /// Assert
//           expect(provider.topRatedTvSeriesState, RequestState.Error);
//           expect(provider.message, "Server Failure");
//           expect(listenerCallCount, 2);
//         },
//       );
//     },
//   );
// }
