import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/core/types/wordlist_filters.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'lists_event.dart';
part 'lists_state.dart';

/// This bloc is used in ListS.dart, jisho.dart and add_marketlist.dart.
@lazySingleton
class ListBloc extends Bloc<ListEvent, ListState> {
  final IListRepository _listRepository;

  ListBloc(this._listRepository) : super(ListStateLoading()) {
    /// Maintain the list for pagination purposes
    List<WordList> list = [];

    /// Maintain the list for pagination purposes on search
    List<WordList> searchList = [];
    const int limit = LazyLoadingLimits.kanList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ListEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(ListStateLoading());
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
        emit(ListStateLoaded(lists: fullList));
      } on Exception {
        emit(ListStateFailure());
      }
    });

    on<ListForTestEventLoading>((event, emit) async {
      try {
        emit(ListStateLoading());
        final List<WordList> lists = await _listRepository.getAllLists();
        emit(ListStateLoaded(lists: lists));
      } on Exception {
        emit(ListStateFailure());
      }
    });

    on<ListEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(ListStateLoading());
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
        emit(ListStateLoaded(lists: fullList));
      } on Exception {
        emit(ListStateFailure());
      }
    });

    on<ListEventDelete>((event, emit) async {
      if (state is ListStateLoaded) {
        String name = event.list.name;
        final code = await _listRepository.removeList(name);
        if (code == 0) {
          emit(ListStateLoading());
          List<WordList> newList =
              await _getNewAllListsAndUpdateLazyLoadingState(
                  event.filter, event.order,
                  limit: limit, l: list);

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(ListStateLoaded(lists: newList));
        }
      }
    });

    on<ListEventCreate>((event, emit) async {
      if (state is ListStateLoaded) {
        String? name = event.name;
        final code = await _listRepository.createList(name);
        if (code == 0) {
          emit(ListStateLoading());
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
          emit(ListStateLoaded(lists: newList));
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
