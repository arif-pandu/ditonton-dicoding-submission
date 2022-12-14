// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
// import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
// import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
// import 'package:ditonton/domain/usecases/remove_watchlist.dart';
// import 'package:ditonton/domain/usecases/save_watchlist.dart';
// import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import '../../dummy_data/dummy_objects.dart';
// import 'tv_series_detail_notifier_test.mocks.dart';

// @GenerateMocks([
//   GetTvSeriesDetail,
//   GetTvSeriesRecommendations,
//   GetWatchListStatus,
//   SaveWatchlist,
//   RemoveWatchlist,
// ])
// void main() {
//   late TvSeriesDetailNotifier provider;
//   late MockGetTvSeriesDetail mockGetTvSeriesDetail;
//   late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
//   late MockGetWatchListStatus mockGetWatchListStatus;
//   late MockSaveWatchlist mockSaveWatchlist;
//   late MockRemoveWatchlist mockRemoveWatchlist;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetTvSeriesDetail = MockGetTvSeriesDetail();
//     mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
//     mockGetWatchListStatus = MockGetWatchListStatus();
//     mockSaveWatchlist = MockSaveWatchlist();
//     mockRemoveWatchlist = MockRemoveWatchlist();
//     provider = TvSeriesDetailNotifier(
//       getTvSeriesDetail: mockGetTvSeriesDetail,
//       getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
//       getWatchListStatus: mockGetWatchListStatus,
//       saveWatchlist: mockSaveWatchlist,
//       removeWatchlist: mockRemoveWatchlist,
//     )..addListener(() {
//         listenerCallCount += 1;
//       });
//   });

//   final tId = 1399;

//   final tTvSeri = TvSeries(
//     posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
//     popularity: 369.594,
//     id: 1399,
//     backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
//     voteAverage: 8.3,
//     overview:
//         "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
//     originCountry: ["US"],
//     genreIds: [10765, 18],
//     originalLanguage: "en",
//     voteCount: 11504,
//     name: "Game of Thrones",
//     originalName: "Game of Thrones",
//   );

//   final tTvSeries = <TvSeries>[tTvSeri];

//   void _arrangeUsecase() {
//     when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Right(testTvSeriesDetail));
//     when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer((_) async => Right(tTvSeries));
//   }

//   group(
//     "Get Tv Series Detail",
//     () {
//       test(
//         "should get data from the usecase",
//         () async {
//           /// Arrange
//           _arrangeUsecase();

//           /// Act
//           await provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           verify(mockGetTvSeriesDetail.execute(tId));
//           verify(mockGetTvSeriesRecommendations.execute(tId));
//         },
//       );

//       test(
//         "should change state to loading when usecase is called",
//         () async {
//           /// Arrange
//           _arrangeUsecase();

//           /// Act
//           provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           expect(provider.tvSeriesState, RequestState.Loading);
//           expect(listenerCallCount, 1);
//         },
//       );

//       test(
//         "should change tv series when data is gotten successfully",
//         () async {
//           /// Arrange
//           _arrangeUsecase();

//           /// Act
//           await provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           expect(provider.tvSeriesState, RequestState.Loaded);
//           expect(provider.tvSeries, testTvSeriesDetail);
//           expect(listenerCallCount, 3);
//         },
//       );

//       test(
//         "should change recommendation tv series when data is gotten successfully",
//         () async {
//           /// Arrange
//           _arrangeUsecase();

//           /// Act
//           await provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           expect(provider.tvSeriesState, RequestState.Loaded);
//           expect(provider.tvSeriesRecommendations, tTvSeries);
//         },
//       );
//     },
//   );

//   group(
//     "Get Tv Series Recommendation",
//     () {
//       test(
//         "should get data from the usecase",
//         () async {
//           /// Arrange
//           _arrangeUsecase();

//           /// Act
//           await provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           verify(mockGetTvSeriesRecommendations.execute(tId));
//           expect(provider.tvSeriesRecommendations, tTvSeries);
//         },
//       );

//       test(
//         "should update recommendation state when data is gotten successfully",
//         () async {
//           /// Arrange
//           _arrangeUsecase();

//           /// Act
//           await provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           expect(provider.recommendationState, RequestState.Loaded);
//           expect(provider.tvSeriesRecommendations, tTvSeries);
//         },
//       );

//       test(
//         "should update error message when request isn't success",
//         () async {
//           /// Arrange
//           when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Right(testTvSeriesDetail));
//           when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer((_) async => Left(ServerFailure("Failed")));

//           /// Act
//           await provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           expect(provider.recommendationState, RequestState.Error);
//           expect(provider.message, "Failed");
//         },
//       );
//     },
//   );

//   group(
//     "Watchlist",
//     () {
//       test(
//         "should get the watchlist status",
//         () async {
//           /// Arrange
//           when(mockGetWatchListStatus.executeTvSeries(tId)).thenAnswer((_) async => true);

//           /// Act
//           await provider.loadWatchListStatus(1399);

//           /// Assert
//           expect(provider.isAddedToWatchlist, true);
//         },
//       );

//       test(
//         "should excute save wathclist when function is called",
//         () async {
//           /// Arrange
//           when(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail)).thenAnswer((_) async => Right("Success"));
//           when(mockGetWatchListStatus.executeTvSeries(testTvSeriesDetail.id)).thenAnswer((_) async => true);

//           /// Act
//           await provider.addWatchlist(testTvSeriesDetail);

//           /// Assert
//           verify(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail));
//         },
//       );

//       test(
//         "should execute remove from watchlist shen function is called",
//         () async {
//           /// Arrange
//           when(mockRemoveWatchlist.executeTvSeries(testTvSeriesDetail)).thenAnswer((_) async => Right("Removed"));
//           when(mockGetWatchListStatus.executeTvSeries(testTvSeriesDetail.id)).thenAnswer((_) async => false);

//           /// Act
//           await provider.removeFromWatchlist(testTvSeriesDetail);

//           /// Assert
//           verify(mockRemoveWatchlist.executeTvSeries(testTvSeriesDetail));
//         },
//       );

//       test(
//         "should update watchlist status when add watchlist success",
//         () async {
//           /// Arrange
//           when(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail))
//               .thenAnswer((_) async => Right("Added to watchlist"));
//           when(mockGetWatchListStatus.executeTvSeries(testTvSeriesDetail.id)).thenAnswer((_) async => true);

//           /// Act
//           await provider.addWatchlist(testTvSeriesDetail);

//           /// Assert
//           verify(mockGetWatchListStatus.executeTvSeries(testTvSeriesDetail.id));
//           expect(provider.isAddedToWatchlist, true);
//           expect(provider.watchListMessage, "Added to watchlist");
//           expect(listenerCallCount, 1);
//         },
//       );

//       test(
//         "should update watchlist message when add watchlist failed",
//         () async {
//           /// Arrange
//           when(mockSaveWatchlist.executeTvSeries(testTvSeriesDetail))
//               .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
//           when(mockGetWatchListStatus.executeTvSeries(testTvSeriesDetail.id)).thenAnswer((_) async => false);

//           /// Act
//           await provider.addWatchlist(testTvSeriesDetail);

//           /// Assert
//           expect(provider.watchListMessage, "Failed");
//           expect(listenerCallCount, 1);
//         },
//       );
//     },
//   );

//   group(
//     "on Error",
//     () {
//       test(
//         "should return error when data is not success",
//         () async {
//           /// Arrange
//           when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure("Server Failure")));
//           when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer((_) async => Right(tTvSeries));

//           /// Act
//           await provider.fetchTvSeriesDetail(tId);

//           /// Assert
//           expect(provider.tvSeriesState, RequestState.Error);
//           expect(provider.message, "Server Failure");
//           expect(listenerCallCount, 2);
//         },
//       );
//     },
//   );
// }
