import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'lists_event.dart';
part 'lists_state.dart';

part 'lists_bloc.freezed.dart';

/// This bloc is used in ListS.dart, jisho.dart and add_marketlist.dart.
@lazySingleton
class ListsBloc extends Bloc<ListsEvent, ListsState> {
  final IListRepository _listRepository;

  ListsBloc(this._listRepository) : super(const ListsState.loading()) {
    /// Maintain the list for pagination purposes
    List<WordList> list = [];

    /// Maintain the list for pagination purposes on search
    List<WordList> searchList = [];
    const int limit = LazyLoadingLimits.kanList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ListsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(const ListsState.loading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<WordList> fullList = List.of(list);
        final List<WordList> pagination = await _listRepository.getAllLists(
            filter: event.filter,
            order: _getSelectedOrder(event.order),
            limit: limit,
            offset: loadingTimes);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(ListsState.loaded(fullList));
      } on Exception {
        emit(const ListsState.error());
      }
    });

    on<ListForTestEventLoading>((event, emit) async {
      try {
        emit(const ListsState.loading());
        final List<WordList> lists = await _listRepository.getAllLists();
        emit(ListsState.loaded(lists));
      } on Exception {
        emit(const ListsState.error());
      }
    });

    on<ListsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(const ListsState.loading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<WordList> fullList = List.of(searchList);
        final List<WordList> pagination =
            await _listRepository.getListsMatchingQuery(event.query,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ListsState.loaded(fullList));
      } on Exception {
        emit(const ListsState.error());
      }
    });

    on<ListsEventDelete>((event, emit) async {
      if (state is ListsLoaded) {
        String name = event.list.name;
        final code = await _listRepository.removeList(name);
        if (code == 0) {
          emit(const ListsState.loading());
          List<WordList> newList =
              await _getNewAllListsAndUpdateLazyLoadingState(
                  event.filter, event.order,
                  limit: limit, l: list);

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(ListsState.loaded(newList));
        }
      }
    });

    on<ListsEventCreate>((event, emit) async {
      if (state is ListsLoaded) {
        String? name = event.name;
        final code = await _listRepository.createList(name);
        if (code == 0) {
          emit(const ListsState.loading());
          List<WordList> newList = [];
          if (event.useLazyLoading) {
            newList = await _getNewAllListsAndUpdateLazyLoadingState(
                event.filter, event.order,
                limit: limit, l: list);
          } else {
            newList = await _listRepository.getAllLists();
          }

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(ListsState.loaded(newList));
        }
      }
    });
  }

  Future<List<WordList>> _getNewAllListsAndUpdateLazyLoadingState(
      WordListFilters filter, bool order,
      {required int limit, required List<WordList> l}) async {
    /// When creating or removing a new list, reset any pagination offset
    /// to load up from the start
    final List<WordList> lists = await _listRepository.getAllLists(
        filter: filter,
        order: _getSelectedOrder(order),
        limit: limit,
        offset: 0);

    /// Clear the list and repopulate it with the newest items for ListEventLoading
    /// to work properly for the next offset
    l.clear();
    l.addAll(lists);
    return lists;
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}
