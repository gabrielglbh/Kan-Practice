import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/folder_filters.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/relation_folder_list/i_relation_folder_list_repository.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'folder_event.dart';
part 'folder_state.dart';

part 'folder_bloc.freezed.dart';

/// This bloc is used in Folders.dart, jisho.dart and add_marketlist.dart.
@lazySingleton
class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final IFolderRepository _folderRepository;
  final IRelationFolderListRepository _relationFolderListRepository;

  FolderBloc(
    this._folderRepository,
    this._relationFolderListRepository,
  ) : super(const FolderState.loading()) {
    /// Maintain the list for pagination purposes
    List<Folder> list = [];

    /// Maintain the list for pagination purposes on search
    List<Folder> searchList = [];
    const int limit = LazyLoadingLimits.folderList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<FolderEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(const FolderState.loading());
          list.clear();
          loadingTimes = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Folder> fullList = List.of(list);
        final List<Folder> pagination = await _folderRepository.getAllFolders(
            filter: event.filter,
            order: _getSelectedOrder(event.order),
            limit: limit,
            offset: loadingTimes);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(FolderState.loaded(fullList));
      } on Exception {
        emit(const FolderState.error());
      }
    });

    on<FolderEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(const FolderState.loading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Folder> fullList = List.of(searchList);
        final List<Folder> pagination =
            await _folderRepository.getListsMatchingQuery(event.query,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(FolderState.loaded(fullList));
      } on Exception {
        emit(const FolderState.error());
      }
    });

    on<FolderForTestEventLoading>((event, emit) async {
      try {
        emit(const FolderState.loading());
        final List<Folder> lists = await _folderRepository.getAllFolders();
        emit(FolderState.loaded(lists));
      } on Exception {
        emit(const FolderState.error());
      }
    });

    on<FolderEventAddSingleList>((event, emit) async {
      try {
        final code = await _relationFolderListRepository.moveListToFolder(
            event.folder, event.name);
        if (code != 0) throw Exception();
        emit(const FolderState.listAdded());
      } catch (e) {
        emit(const FolderState.error());
      }
    });

    on<FolderEventDelete>((event, emit) async {
      if (state is FolderLoaded) {
        String name = event.list.folder;
        final code = await _folderRepository.removeFolder(name);
        if (code == 0) {
          emit(const FolderState.loading());
          List<Folder> newList = await _getNewAllListsAndUpdateLazyLoadingState(
              event.filter, event.order,
              limit: limit, l: list);

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(FolderState.loaded(newList));
        }
      }
    });

    on<FolderEventCreate>((event, emit) async {
      if (state is FolderLoaded) {
        String? name = event.name;
        final code = await _folderRepository.createFolder(name);
        if (code == 0) {
          emit(const FolderState.loading());
          List<Folder> newList = [];
          if (event.useLazyLoading) {
            newList = await _getNewAllListsAndUpdateLazyLoadingState(
                event.filter, event.order,
                limit: limit, l: list);
          } else {
            newList = await _folderRepository.getAllFolders();
          }

          /// Reset offsets
          loadingTimes = 0;
          loadingTimesForSearch = 0;
          emit(FolderState.loaded(newList));
        }
      }
    });
  }

  Future<List<Folder>> _getNewAllListsAndUpdateLazyLoadingState(
      FolderFilters filter, bool order,
      {required int limit, required List<Folder> l}) async {
    /// When creating or removing a new list, reset any pagination offset
    /// to load up from the start
    final List<Folder> lists = await _folderRepository.getAllFolders(
        filter: filter,
        order: _getSelectedOrder(order),
        limit: limit,
        offset: 0);

    /// Clear the list and repopulate it with the newest items for FolderEventLoading
    /// to work properly for the next offset
    l.clear();
    l.addAll(lists);
    return lists;
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}
