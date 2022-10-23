part of 'test_category_selection_bloc.dart';

abstract class TestCategorySelectionState extends Equatable {
  const TestCategorySelectionState();

  @override
  List<Object> get props => [];
}

class TestCategorySelectionStateIdle extends TestCategorySelectionState {}

class TestCategorySelectionStateLoadedList extends TestCategorySelectionState {
  final List<Word> words;

  const TestCategorySelectionStateLoadedList(this.words);

  @override
  List<Object> get props => [words];
}
