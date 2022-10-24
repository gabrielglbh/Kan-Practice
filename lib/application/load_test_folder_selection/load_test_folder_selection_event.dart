part of 'load_test_folder_selection_bloc.dart';

abstract class LoadTestFolderSelectionEvent extends Equatable {
  const LoadTestFolderSelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadTestFolderSelectionEventIdle extends LoadTestFolderSelectionEvent {}

class LoadTestFolderSelectionEventLoadList
    extends LoadTestFolderSelectionEvent {
  final List<String> folders;

  const LoadTestFolderSelectionEventLoadList({required this.folders});
}
