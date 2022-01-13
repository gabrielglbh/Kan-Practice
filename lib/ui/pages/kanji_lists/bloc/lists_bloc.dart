import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';

part 'lists_event.dart';
part 'lists_state.dart';

/// This bloc is used in kanji_lists.dart and jisho.dart
class KanjiListBloc extends Bloc<KanjiListEvent, KanjiListState> {
  KanjiListBloc() : super(KanjiListStateLoading()) {
    /// Maintain the list for pagination purposes
    List<KanjiList> _list = [];
    /// Maintain the list for pagination purposes on search
    List<KanjiList> _searchList = [];
    final int _limit = 8;

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

    /// TODO: Next batch not working correctly
    on<KanjiListEventDelete>((event, emit) async {
      if (state is KanjiListStateLoaded) {
        String name = event.list.name;
        final code = await ListQueries.instance.removeList(name);
        if (code == 0) {
          /// When removing a new list, reset any pagination offset to load up,
          /// from the start
          emit(KanjiListStateLoading());
          final lists = await ListQueries.instance.getAllLists(
            filter: event.filter,
            order: _getSelectedOrder(event.order),
            limit: _limit,
            offset: 0
          );
          _list.clear();
          emit(KanjiListStateLoaded(lists: lists));
        }
      }
    });

    /// TODO: Next batch not working correctly
    on<KanjiListEventCreate>((event, emit) async {
      if (state is KanjiListStateLoaded) {
        String? name = event.name;
        final code = await ListQueries.instance.createList(name);
        if (code == 0) {
          /// When creating a new list, reset any pagination offset to load up,
          /// from the start
          emit(KanjiListStateLoading());
          final lists = await ListQueries.instance.getAllLists(
            filter: event.filter,
            order: _getSelectedOrder(event.order),
            limit: _limit,
            offset: 0
          );
          _list.clear();
          emit(KanjiListStateLoaded(lists: lists));
        }
      }
    });
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}