part of 'load_folder_practice_bloc.dart';

abstract class LoadFolderPracticeEvent extends Equatable {
  const LoadFolderPracticeEvent();

  @override
  List<Object> get props => [];
}

class LoadFolderPracticeEventLoadList extends LoadFolderPracticeEvent {
  final String folder;
  final StudyModes mode;

  const LoadFolderPracticeEventLoadList(
      {required this.folder, required this.mode});

  @override
  List<Object> get props => [mode, folder];
}
