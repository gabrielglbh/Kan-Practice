part of 'test_bloc.dart';

abstract class TestListEvent extends Equatable {
  const TestListEvent();

  @override
  List<Object> get props => [];
}

class TestListEventIdle extends TestListEvent {}

class TestListEventLoading extends TestListEvent {
  final DateTime initial;
  final DateTime last;
  final TestFilters testFilter;
  final StudyModeFilters modesFilter;

  const TestListEventLoading({
    required this.initial,
    required this.last,
    this.testFilter = TestFilters.all,
    this.modesFilter = StudyModeFilters.all,
  });

  @override
  List<Object> get props => [initial, last, modesFilter, modesFilter];
}

class TestListEventRemoving extends TestListEvent {}
