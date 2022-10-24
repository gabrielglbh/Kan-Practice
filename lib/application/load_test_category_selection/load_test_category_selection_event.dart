part of 'load_test_category_selection_bloc.dart';

abstract class LoadTestCategorySelectionEvent extends Equatable {
  const LoadTestCategorySelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadTestCategorySelectionEventLoadList
    extends LoadTestCategorySelectionEvent {
  final WordCategory category;
  final String? folder;

  const LoadTestCategorySelectionEventLoadList({
    required this.category,
    required this.folder,
  });

  @override
  List<Object> get props => [category];
}
