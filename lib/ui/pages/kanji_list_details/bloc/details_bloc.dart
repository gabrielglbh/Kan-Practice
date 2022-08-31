import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/consts.dart';

part 'details_event.dart';
part 'details_state.dart';

class KanjiListDetailBloc
    extends Bloc<KanjiListDetailEvent, KanjiListDetailState> {
  KanjiListDetailBloc() : super(KanjiListDetailStateLoading()) {
    /// Maintain the list for pagination purposes
    List<Kanji> list = [];

    /// Maintain the list for pagination purposes on search
    List<Kanji> searchList = [];
    const int limit = LazyLoadingLimits.wordList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<KanjiEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(KanjiListDetailStateLoading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Kanji> fullList = List.of(list);
        final List<Kanji> pagination = await KanjiQueries.instance
            .getAllKanjiFromList(event.list,
                offset: loadingTimes, limit: limit);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(KanjiListDetailStateLoaded(fullList, event.list));
      } on Exception {
        emit(const KanjiListDetailStateFailure());
      }
    });

    on<KanjiEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(KanjiListDetailStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Kanji> fullList = List.of(searchList);
        final List<Kanji> pagination = await KanjiQueries.instance
            .getKanjiMatchingQuery(event.query, event.list,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(KanjiListDetailStateLoaded(fullList, event.list));
      } on Exception {
        emit(const KanjiListDetailStateFailure());
      }
    });

    on<UpdateKanList>((event, emit) async {
      emit(KanjiListDetailStateLoading());
      final error = await ListQueries.instance
          .updateList(event.og, {KanListTableFields.nameField: event.name});
      if (error == 0) {
        /// When updating the list's name, reset any pagination offset
        /// to load up from the start
        final List<Kanji> lists = await KanjiQueries.instance
            .getAllKanjiFromList(event.name, limit: limit, offset: 0);

        /// Clear the list and repopulate it with the newest items for KanjiListEventLoading
        /// to work properly for the next offset
        list.clear();
        list.addAll(lists);

        /// Reset offsets
        loadingTimes = 0;
        loadingTimesForSearch = 0;
        emit(KanjiListDetailStateLoaded(lists, event.name));
      } else {
        emit(const KanjiListDetailStateFailure());
      }
    });

    on<KanjiEventLoadUpPractice>((event, emit) async {
      try {
        final List<Kanji> allList =
            await KanjiQueries.instance.getAllKanjiFromList(event.list);
        if (allList.isNotEmpty) {
          allList.shuffle();
          List<Kanji> list = allList;
          emit(KanjiListDetailStateLoadedPractice(event.studyMode, list));
        } else {
          emit(KanjiListDetailStateFailure(
              error: "list_details_loadUpPractice_failed".tr()));
        }
      } on Exception {
        emit(const KanjiListDetailStateFailure());
      }
    });
  }
}
