part of 'folder_details_bloc.dart';

@freezed
class FolderDetailsState with _$FolderDetailsState {
  const factory FolderDetailsState.loading() = FolderDetailsLoading;
  const factory FolderDetailsState.loaded(List<WordList> lists) =
      FolderDetailsLoaded;
  const factory FolderDetailsState.testLoaded(List<WordList> lists) =
      FolderDetailsTestLoaded;
  const factory FolderDetailsState.initial() = FolderDetailsInitial;
  const factory FolderDetailsState.error() = FolderDetailsError;
}
