part of 'load_folder_practice_bloc.dart';

abstract class LoadFolderPracticeState extends Equatable {
  const LoadFolderPracticeState();

  @override
  List<Object> get props => [];
}

class LoadFolderPracticeStateIdle extends LoadFolderPracticeState {}

class LoadFolderPracticeStateLoadedList extends LoadFolderPracticeState {
  final List<Word> words;
  final StudyModes mode;

  const LoadFolderPracticeStateLoadedList(this.words, this.mode);

  @override
  List<Object> get props => [words, mode];
}
