import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/relation_folder_list/i_relation_folder_list_repository.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'folder_details_event.dart';
part 'folder_details_state.dart';

/// This bloc is used in Folders.dart, jisho.dart and add_marketlist.dart.
@lazySingleton
class FolderDetailsBloc extends Bloc<FolderDetailsEvent, FolderDetailsState> {
  final IFolderRepository _folderRepository;
  final IRelationFolderListRepository _relationFolderListRepository;

  FolderDetailsBloc(
    this._folderRepository,
    this._relationFolderListRepository,
  ) : super(FolderDetailsStateIdle()) {
    /// Maintain the list for pagination purposes
    List<WordList> list = [];

    /// Maintain the list for pagination purposes on search
    List<WordList> searchList = [];
    const int limit = LazyLoadingLimits.kanList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<FolderDetailsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(FolderDetailsStateLoading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<WordList> fullList = List.of(list);
        final List<WordList> pagination =
            await _folderRepository.getAllListsOnFolder(
          event.folder,
          filter: event.filter,
          order: _getSelectedOrder(event.order),
          limit: limit,
          offset: loadingTimes,
        );
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(FolderDetailsStateLoaded(lists: fullList));
      } on Exception {
        emit(FolderDetailsStateFailure());
      }
    });

    on<FolderForTestEventLoading>((event, emit) async {
      try {
        emit(FolderDetailsStateLoading());
        final List<WordList> lists =
            await _folderRepository.getAllListsOnFolder(event.folder);
        emit(FolderDetailsStateTestLoaded(lists: lists));
      } on Exception {
        emit(FolderDetailsStateFailure());
      }
    });

    on<FolderDetailsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(FolderDetailsStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<WordList> fullList = List.of(searchList);
        final List<WordList> pagination =
            await _folderRepository.getAllListsOnFolderOnQuery(
          event.query,
          event.folder,
          offset: loadingTimesForSearch,
          limit: limit,
        );
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(FolderDetailsStateLoaded(lists: fullList));
      } on Exception {
        emit(FolderDetailsStateFailure());
      }
    });

    on<FolderDetailsEventDelete>((event, emit) async {
      if (state is FolderDetailsStateLoaded) {
        String name = event.list.name;

        final code = await _relationFolderListRepository.removeListToFolder(
            event.folder, name);
        if (code == 0) {
          emit(FolderDetailsStateLoading());
          List<WordList> newList =
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
          emit(FolderDetailsStateLoaded(lists: newList));
        }
      }
    });
  }

  Future<List<WordList>> _getNewAllListsAndUpdateLazyLoadingState(
      String folder, WordListFilters filter, bool order,
      {required int limit, required List<WordList> l}) async {
    /// When creating or removing a new list, reset any pagination offset
    /// to load up from the start
    final List<WordList> lists = await _folderRepository.getAllListsOnFolder(
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
