part of 'folder_practice_bloc.dart';

@freezed
class FolderPracticeState with _$FolderPracticeState {
  const factory FolderPracticeState.initial() = FolderPracticeInitial;
  const factory FolderPracticeState.loaded(List<Word> list, StudyModes mode) =
      FolderPracticeLoaded;
}
