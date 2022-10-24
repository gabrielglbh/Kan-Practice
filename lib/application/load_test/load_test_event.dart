part of 'load_test_bloc.dart';

abstract class LoadTestEvent extends Equatable {
  const LoadTestEvent();

  @override
  List<Object> get props => [];
}

class LoadTestEventIdle extends LoadTestEvent {}

class LoadTestEventLoadList extends LoadTestEvent {
  final String? folder;
  final StudyModes mode;
  final Tests type;
  final String? practiceList;

  const LoadTestEventLoadList({
    required this.folder,
    required this.mode,
    required this.type,
    this.practiceList,
  });

  @override
  List<Object> get props => [mode, type];
}
