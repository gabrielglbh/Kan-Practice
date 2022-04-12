import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/ui/theme/consts.dart';

part 'lists_event.dart';
part 'lists_state.dart';

/// This bloc is used in kanji_lists.dart and jisho.dart
class KanjiListBloc extends Bloc<KanjiListEvent, KanjiListState> {
  KanjiListBloc() : super(KanjiListStateLoading()) {
    /// Maintain the list for pagination purposes
    List<KanjiList> _list = [];
    /// Maintain the list for pagination purposes on search
    List<KanjiList> _searchList = [];
    final int _limit = LazyLoadingLimits.kanList;

    on<KanjiListEventLoading>((event, emit) async {
      try {
        if (event.offset == 0) {
          emit(KanjiListStateLoading());
          _list.clear();
        }
        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to _list the elements for the next iteration.
        List<KanjiList> fullList = List.of(_list);
        final List<KanjiList> pagination = await ListQueries.instance.getAllLists(
          filter: event.filter,
          order: _getSelectedOrder(event.order),
          limit: _limit,
          offset: event.offset
        );
        fullList.addAll(pagination);
        _list.addAll(pagination);
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
        if (event.offset == 0) {
          emit(KanjiListStateLoading());
          _searchList.clear();
        }
        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to _list the elements for the next iteration.
        List<KanjiList> fullList = List.of(_searchList);
        final List<KanjiList> pagination = await ListQueries.instance.getListsMatchingQuery(
            event.query, offset: event.offset, limit: _limit
        );
        fullList.addAll(pagination);
        _searchList.addAll(pagination);
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
          List<KanjiList> newList = await _getNewAllListsAndUpdateLazyLoadingState(
              event.filter, event.order, limit: _limit, l: _list
          );
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
                event.filter, event.order, limit: _limit, l: _list
            );
          }
          else newList = await ListQueries.instance.getAllLists();
          emit(KanjiListStateLoaded(lists: newList));
        }
      }
    });
  }

  Future<List<KanjiList>> _getNewAllListsAndUpdateLazyLoadingState(
      String filter, bool order, {required int limit, required List<KanjiList> l}) async {
    /// When creating or removing a new list, reset any pagination offset
    /// to load up from the start
    final List<KanjiList> lists = await ListQueries.instance.getAllLists(
        filter: filter,
        order: _getSelectedOrder(order),
        limit: limit,
        offset: 0
    );
    /// Clear the _list and repopulate it with the newest items for KanjiListEventLoading
    /// to work properly for the next offset
    l.clear();
    l.addAll(lists);
    return lists;
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}