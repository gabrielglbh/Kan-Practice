part of 'load_test_folder_selection_bloc.dart';

abstract class LoadTestFolderSelectionState extends Equatable {
  const LoadTestFolderSelectionState();

  @override
  List<Object> get props => [];
}

class LoadTestFolderSelectionStateIdle extends LoadTestFolderSelectionState {}

class LoadTestFolderSelectionStateLoadedList
    extends LoadTestFolderSelectionState {
  final List<Word> words;

  const LoadTestFolderSelectionStateLoadedList(this.words);

  @override
  List<Object> get props => [words];
}
