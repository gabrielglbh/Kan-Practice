part of 'test_load_bloc.dart';

abstract class TestLoadEvent extends Equatable {
  const TestLoadEvent();

  @override
  List<Object> get props => [];
}

class TestLoadEventIdle extends TestLoadEvent {}

class TestLoadEventLoadList extends TestLoadEvent {
  final String? folder;
  final StudyModes mode;
  final Tests type;
  final String? practiceList;

  const TestLoadEventLoadList({
    required this.folder,
    required this.mode,
    required this.type,
    this.practiceList,
  });

  @override
  List<Object> get props => [mode, type];
}
