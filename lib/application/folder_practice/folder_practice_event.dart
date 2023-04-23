part of 'folder_practice_bloc.dart';

abstract class FolderPracticeEvent extends Equatable {
  const FolderPracticeEvent();

  @override
  List<Object> get props => [];
}

class FolderPracticeEventLoadList extends FolderPracticeEvent {
  final String folder;
  final StudyModes mode;

  const FolderPracticeEventLoadList({required this.folder, required this.mode});

  @override
  List<Object> get props => [mode, folder];
}
