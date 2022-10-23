part of 'test_category_selection_bloc.dart';

abstract class TestCategorySelectionEvent extends Equatable {
  const TestCategorySelectionEvent();

  @override
  List<Object> get props => [];
}

class TestCategorySelectionEventIdle extends TestCategorySelectionEvent {}

class TestCategorySelectionEventLoadList extends TestCategorySelectionEvent {
  final WordCategory category;
  final String? folder;

  const TestCategorySelectionEventLoadList({
    required this.category,
    required this.folder,
  });

  @override
  List<Object> get props => [category];
}
