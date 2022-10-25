part of 'load_test_list_selection_bloc.dart';

abstract class LoadTestListSelectionEvent extends Equatable {
  const LoadTestListSelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadTestListSelectionEventLoadList extends LoadTestListSelectionEvent {
  final List<String> lists;

  const LoadTestListSelectionEventLoadList({required this.lists});
}
