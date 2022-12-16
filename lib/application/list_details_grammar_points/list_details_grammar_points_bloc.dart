import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'list_details_grammar_points_event.dart';
part 'list_details_grammar_points_state.dart';

@lazySingleton
class ListDetailGrammarPointsBloc
    extends Bloc<ListDetailGrammarPointsEvent, ListDetailGrammarPointsState> {
  final IGrammarPointRepository _grammarPointRepository;

  ListDetailGrammarPointsBloc(this._grammarPointRepository)
      : super(ListDetailGrammarPointsStateIdle()) {
    /// Maintain the list for pagination purposes
    List<GrammarPoint> list = [];

    /// Maintain the list for pagination purposes on search
    List<GrammarPoint> searchList = [];
    const int limit = LazyLoadingLimits.wordList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ListDetailGrammarPointsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(ListDetailGrammarPointsStateLoading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<GrammarPoint> fullList = List.of(list);
        final List<GrammarPoint> pagination = await _grammarPointRepository
            .getAllGrammarPointsFromList(event.list,
                offset: loadingTimes, limit: limit);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(ListDetailGrammarPointsStateLoaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailGrammarPointsStateFailure());
      }
    });

    on<ListDetailGrammarPointsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(ListDetailGrammarPointsStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<GrammarPoint> fullList = List.of(searchList);
        final List<GrammarPoint> pagination = await _grammarPointRepository
            .getGrammarPointsMatchingQuery(event.query, event.list,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ListDetailGrammarPointsStateLoaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailGrammarPointsStateFailure());
      }
    });

    on<ListDetailGrammarPointsEventLoadUpPractice>((event, emit) async {
      try {
        final List<GrammarPoint> allList = await _grammarPointRepository
            .getAllGrammarPointsFromList(event.list);
        if (allList.isNotEmpty) {
          allList.shuffle();
          List<GrammarPoint> list = allList;
          emit(ListDetailGrammarPointsStateLoadedPractice(
              event.studyMode, list));
        } else {
          emit(ListDetailGrammarPointsStateFailure(
              error: "list_details_loadUpPractice_failed".tr()));
        }
      } on Exception {
        emit(const ListDetailGrammarPointsStateFailure());
      }
    });
  }
}
