part of 'folder_bloc.dart';

@freezed
class FolderState with _$FolderState {
  const factory FolderState.loading() = FolderLoading;
  const factory FolderState.loaded(List<Folder> lists) = FolderLoaded;
  const factory FolderState.listAdded() = FolderListAdded;
  const factory FolderState.error() = FolderError;
}
