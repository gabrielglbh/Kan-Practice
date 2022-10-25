part of 'load_test_list_selection_bloc.dart';

abstract class LoadTestListSelectionState extends Equatable {
  const LoadTestListSelectionState();

  @override
  List<Object> get props => [];
}

class LoadTestListSelectionStateIdle extends LoadTestListSelectionState {}

class LoadTestListSelectionStateLoadedList extends LoadTestListSelectionState {
  final List<Word> words;

  const LoadTestListSelectionStateLoadedList(this.words);

  @override
  List<Object> get props => [words];
}
