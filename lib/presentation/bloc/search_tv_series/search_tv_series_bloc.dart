import 'package:bloc/bloc.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  SearchTvSeriesBloc(
    this.searchTvSeries,
  ) : super(SearchTvSeriesEmpty()) {
    on<OnQueryTvSeriesChanged>(
      _onQueryChanged,
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }

  final SearchTvSeries searchTvSeries;

  void _onQueryChanged(
    OnQueryTvSeriesChanged event,
    Emitter<SearchTvSeriesState> emit,
  ) async {
    emit(SearchTvSeriesLoading());

    final result = await searchTvSeries.execute(event.query);

    result.fold(
      (failure) {
        emit(SearchTvSeriesError(failure.message));
      },
      (success) {
        emit(SearchTvSeriesHasResult(success));
      },
    );
  }
}
