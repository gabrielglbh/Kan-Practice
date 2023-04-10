part of 'add_folder_bloc.dart';

@freezed
class AddFolderState with _$AddFolderState {
  const factory AddFolderState.loading() = AddFolderLoading;
  const factory AddFolderState.loaded() = AddFolderLoaded;
  const factory AddFolderState.initial() = AddFolderInitial;
  const factory AddFolderState.loadedLists(
    List<WordList> lists,
    Map<String, bool> alreadyAdded,
  ) = AddFolderLoadedLists;
  const factory AddFolderState.error(String message) = AddFolderError;
}
