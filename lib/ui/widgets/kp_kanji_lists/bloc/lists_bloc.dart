import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/ui/consts.dart';

part 'lists_event.dart';
part 'lists_state.dart';

/// This bloc is used in kanjilists.dart, jisho.dart and add_marketlist.dart.
class KanjiListBloc extends Bloc<KanjiListEvent, KanjiListState> {
  KanjiListBloc() : super(KanjiListStateLoading()) {
    /// Maintain the list for pagination purposes
    List<KanjiList> list = [];

    /// Maintain the list for pagination purposes on search
    List<KanjiList> searchList = [];
    const int limit = LazyLoadingLimits.kanList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<KanjiListEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(KanjiListStateLoading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<KanjiList> fullList = List.of(list);
        final List<KanjiList> pagination = await ListQueries.instance
            .getAllLists(
                filter: event.filter,
                order: _getSelectedOrder(event.order),
                limit: limit,
                offset: loadingTimes);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(KanjiListStateLoaded(lists: fullList));
      } on Exception {
        emit(KanjiListStateFailure());
      }
    });

    on<KanjiListForTestEventLoading>((event, emit) async {
      try {
        emit(KanjiListStateLoading());
        final List<KanjiList> lists = await ListQueries.instance.getAllLists();
        emit(KanjiListStateLoaded(lists: lists));
      } on Exception {
        emit(KanjiListStateFailure());
      }
    });

    on<KanjiListEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(KanjiListStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<KanjiList> fullList = List.of(searchList);
        final List<KanjiList> pagination = await ListQueries.instance
            .getListsMatchingQuery(event.query,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(KanjiListStateLoaded(lists: fullList));
      } on Exception {
        emit(KanjiListStateFailure());
      }
    });

    on<KanjiListEventDelete>((event, emit) async {
      if (state is KanjiListStateLoaded) {
        String name = event.list.name;
        final code = await ListQueries.instance.removeList(name);
        if (code == 0) {
          emit(KanjiListStateLoading());
          List<KanjiList> newList =
              await _getNewAllListsAndUpdateLazyLoadingState(
                  event.filter, event.order,
                  limit: limit, l: list);

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(KanjiListStateLoaded(lists: newList));
        }
      }
    });

    on<KanjiListEventCreate>((event, emit) async {
      if (state is KanjiListStateLoaded) {
        String? name = event.name;
        final code = await ListQueries.instance.createList(name);
        if (code == 0) {
          emit(KanjiListStateLoading());
          List<KanjiList> newList = [];
          if (event.useLazyLoading) {
            newList = await _getNewAllListsAndUpdateLazyLoadingState(
                event.filter, event.order,
                limit: limit, l: list);
          } else {
            newList = await ListQueries.instance.getAllLists();
          }

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(KanjiListStateLoaded(lists: newList));
        }
      }
    });
  }

  Future<List<KanjiList>> _getNewAllListsAndUpdateLazyLoadingState(
      KanListFilters filter, bool order,
      {required int limit, required List<KanjiList> l}) async {
    /// When creating or removing a new list, reset any pagination offset
    /// to load up from the start
    final List<KanjiList> lists = await ListQueries.instance.getAllLists(
        filter: filter,
        order: _getSelectedOrder(order),
        limit: limit,
        offset: 0);

    /// Clear the list and repopulate it with the newest items for KanjiListEventLoading
    /// to work properly for the next offset
    l.clear();
    l.addAll(lists);
    return lists;
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}
