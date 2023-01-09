import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'archive_grammar_points_event.dart';
part 'archive_grammar_points_state.dart';

@lazySingleton
class ArchiveGrammarPointsBloc
    extends Bloc<ArchiveGrammarPointsEvent, ArchiveGrammarPointsState> {
  final IGrammarPointRepository _grammarPointRepository;

  ArchiveGrammarPointsBloc(this._grammarPointRepository)
      : super(ArchiveGrammarPointsStateIdle()) {
    /// Maintain the list for pagination purposes
    List<GrammarPoint> list = [];

    /// Maintain the list for pagination purposes on search
    List<GrammarPoint> searchList = [];
    const int limit = LazyLoadingLimits.grammarPointList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ArchiveGrammarPointsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(ArchiveGrammarPointsStateLoading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<GrammarPoint> fullList = List.of(list);
        final List<GrammarPoint> pagination = await _grammarPointRepository
            .getArchiveGrammarPoints(offset: loadingTimes, limit: limit);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(ArchiveGrammarPointsStateLoaded(fullList));
      } on Exception {
        emit(const ArchiveGrammarPointsStateFailure());
      }
    });

    on<ArchiveGrammarPointsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(ArchiveGrammarPointsStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<GrammarPoint> fullList = List.of(searchList);
        final List<GrammarPoint> pagination = await _grammarPointRepository
            .getGrammarPointsMatchingQuery(event.query,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ArchiveGrammarPointsStateLoaded(fullList));
      } on Exception {
        emit(const ArchiveGrammarPointsStateFailure());
      }
    });
  }
}