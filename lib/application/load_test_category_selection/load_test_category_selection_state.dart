part of 'load_test_category_selection_bloc.dart';

abstract class LoadTestCategorySelectionState extends Equatable {
  const LoadTestCategorySelectionState();

  @override
  List<Object> get props => [];
}

class LoadTestCategorySelectionStateIdle
    extends LoadTestCategorySelectionState {}

class LoadTestCategorySelectionStateLoadedList
    extends LoadTestCategorySelectionState {
  final List<Word> words;

  const LoadTestCategorySelectionStateLoadedList(this.words);

  @override
  List<Object> get props => [words];
}
