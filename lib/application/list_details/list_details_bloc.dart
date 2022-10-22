import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'list_details_event.dart';
part 'list_details_state.dart';

class ListDetailBloc extends Bloc<ListDetailEvent, ListDetailState> {
  ListDetailBloc() : super(ListDetailStateLoading()) {
    /// Maintain the list for pagination purposes
    List<Word> list = [];

    /// Maintain the list for pagination purposes on search
    List<Word> searchList = [];
    const int limit = LazyLoadingLimits.wordList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ListDetailEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(ListDetailStateLoading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Word> fullList = List.of(list);
        final List<Word> pagination = await WordQueries.instance
            .getAllKanjiFromList(event.list,
                offset: loadingTimes, limit: limit);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(ListDetailStateLoaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailStateFailure());
      }
    });

    on<ListDetailEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(ListDetailStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Word> fullList = List.of(searchList);
        final List<Word> pagination = await WordQueries.instance
            .getKanjiMatchingQuery(event.query, event.list,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ListDetailStateLoaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailStateFailure());
      }
    });

    on<ListDetailUpdateName>((event, emit) async {
      emit(ListDetailStateLoading());
      final error = await ListQueries.instance
          .updateList(event.og, {KanListTableFields.nameField: event.name});
      if (error == 0) {
        /// When updating the list's name, reset any pagination offset
        /// to load up from the start
        final List<Word> lists = await WordQueries.instance
            .getAllKanjiFromList(event.name, limit: limit, offset: 0);

        /// Clear the list and repopulate it with the newest items for WordListEventLoading
        /// to work properly for the next offset
        list.clear();
        list.addAll(lists);

        /// Reset offsets
        loadingTimes = 0;
        loadingTimesForSearch = 0;
        emit(ListDetailStateLoaded(lists, event.name));
      } else {
        emit(const ListDetailStateFailure());
      }
    });

    on<ListDetailEventLoadUpPractice>((event, emit) async {
      try {
        final List<Word> allList =
            await WordQueries.instance.getAllKanjiFromList(event.list);
        if (allList.isNotEmpty) {
          allList.shuffle();
          List<Word> list = allList;
          emit(ListDetailStateLoadedPractice(event.studyMode, list));
        } else {
          emit(ListDetailStateFailure(
              error: "list_details_loadUpPractice_failed".tr()));
        }
      } on Exception {
        emit(const ListDetailStateFailure());
      }
    });
  }
}
