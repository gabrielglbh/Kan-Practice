import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'list_details_grammar_points_event.dart';
part 'list_details_grammar_points_state.dart';

part 'list_details_grammar_points_bloc.freezed.dart';

@lazySingleton
class ListDetailsGrammarPointsBloc
    extends Bloc<ListDetailsGrammarPointsEvent, ListDetailsGrammarPointsState> {
  final IGrammarPointRepository _grammarPointRepository;

  ListDetailsGrammarPointsBloc(this._grammarPointRepository)
      : super(const ListDetailsGrammarPointsState.initial()) {
    /// Maintain the list for pagination purposes
    List<GrammarPoint> list = [];

    /// Maintain the list for pagination purposes on search
    List<GrammarPoint> searchList = [];
    const int limit = LazyLoadingLimits.grammarPointList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ListDetailsGrammarPointsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(const ListDetailsGrammarPointsState.loading());
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
        emit(ListDetailsGrammarPointsState.loaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailsGrammarPointsState.error(''));
      }
    });

    on<ListDetailsGrammarPointsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(const ListDetailsGrammarPointsState.loading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<GrammarPoint> fullList = List.of(searchList);
        final List<GrammarPoint> pagination = await _grammarPointRepository
            .getGrammarPointsMatchingQuery(event.query,
                listName: event.list,
                offset: loadingTimesForSearch,
                limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ListDetailsGrammarPointsState.loaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailsGrammarPointsState.error(''));
      }
    });

    on<ListDetailsGrammarPointsEventLoadUpPractice>((event, emit) async {
      try {
        final List<GrammarPoint> allList = await _grammarPointRepository
            .getAllGrammarPointsFromList(event.list);
        if (allList.isNotEmpty) {
          allList.shuffle();
          List<GrammarPoint> list = allList;
          emit(ListDetailsGrammarPointsState.practiceLoaded(
              event.grammarMode, list));
        } else {
          emit(ListDetailsGrammarPointsState.error(
              "list_details_loadUpPractice_failed".tr()));
        }
      } on Exception {
        emit(const ListDetailsGrammarPointsState.error(''));
      }
    });
  }
}
