part of 'generic_test_bloc.dart';

abstract class GenericTestEvent extends Equatable {
  const GenericTestEvent();

  @override
  List<Object> get props => [];
}

class GenericTestEventIdle extends GenericTestEvent {
  final Tests mode;

  const GenericTestEventIdle({required this.mode});

  @override
  List<Object> get props => [mode];
}

class GenericTestEventLoadList extends GenericTestEvent {
  final String? folder;
  final StudyModes mode;
  final Tests type;
  final String? practiceList;
  final List<String>? selectionQuery;

  const GenericTestEventLoadList({
    required this.folder,
    required this.mode,
    required this.type,
    this.practiceList,
    this.selectionQuery,
  });

  @override
  List<Object> get props => [mode, type];
}
