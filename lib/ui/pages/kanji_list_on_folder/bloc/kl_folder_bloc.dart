import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/ui/consts.dart';

part 'kl_folder_event.dart';
part 'kl_folder_state.dart';

/// This bloc is used in Folders.dart, jisho.dart and add_marketlist.dart.
class KLFolderBloc extends Bloc<KLFolderEvent, KLFolderState> {
  KLFolderBloc() : super(KLFolderStateLoading()) {
    /// Maintain the list for pagination purposes
    List<KanjiList> list = [];

    /// Maintain the list for pagination purposes on search
    List<KanjiList> searchList = [];
    const int limit = LazyLoadingLimits.kanList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<KLFolderEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(KLFolderStateLoading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<KanjiList> fullList = List.of(list);
        final List<KanjiList> pagination =
            await FolderQueries.instance.getAllListsOnFolder(
          event.folder,
          filter: event.filter,
          order: _getSelectedOrder(event.order),
          limit: limit,
          offset: loadingTimes,
        );
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(KLFolderStateLoaded(lists: fullList));
      } on Exception {
        emit(KLFolderStateFailure());
      }
    });

    on<FolderForTestEventLoading>((event, emit) async {
      try {
        emit(KLFolderStateLoading());
        final List<KanjiList> lists =
            await FolderQueries.instance.getAllListsOnFolder(event.folder);
        emit(KLFolderStateTestLoaded(lists: lists));
      } on Exception {
        emit(KLFolderStateFailure());
      }
    });

    on<KLFolderEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(KLFolderStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<KanjiList> fullList = List.of(searchList);
        final List<KanjiList> pagination =
            await FolderQueries.instance.getAllListsOnFolderOnQuery(
          event.query,
          event.folder,
          offset: loadingTimesForSearch,
          limit: limit,
        );
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(KLFolderStateLoaded(lists: fullList));
      } on Exception {
        emit(KLFolderStateFailure());
      }
    });

    on<KLFolderEventDelete>((event, emit) async {
      if (state is KLFolderStateLoaded) {
        String name = event.list.name;

        final code = await FolderQueries.instance
            .removeKanListToFolder(event.folder, name);
        if (code == 0) {
          emit(KLFolderStateLoading());
          List<KanjiList> newList =
              await _getNewAllListsAndUpdateLazyLoadingState(
            event.folder,
            event.filter,
            event.order,
            limit: limit,
            l: list,
          );

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(KLFolderStateLoaded(lists: newList));
        }
      }
    });
  }

  Future<List<KanjiList>> _getNewAllListsAndUpdateLazyLoadingState(
      String folder, KanListFilters filter, bool order,
      {required int limit, required List<KanjiList> l}) async {
    /// When creating or removing a new list, reset any pagination offset
    /// to load up from the start
    final List<KanjiList> lists =
        await FolderQueries.instance.getAllListsOnFolder(
      folder,
      filter: filter,
      order: _getSelectedOrder(order),
      limit: limit,
      offset: 0,
    );

    /// Clear the list and repopulate it with the newest items for FolderEventLoading
    /// to work properly for the next offset
    l.clear();
    l.addAll(lists);
    return lists;
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}
