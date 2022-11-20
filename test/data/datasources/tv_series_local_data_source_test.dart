import 'package:ditonton/data/datasources/tv_series_local_data_resorce.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSource dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  // group(
  //   "save watchlist",
  //   () {
  //     test(
  //       "should return success message when insert to database is success",
  //       () async {
  //         when(mockDatabaseHelper.insertTvSeriesWatchlist(tvSeries));
  //       },
  //     );
  //   },
  // );
}
