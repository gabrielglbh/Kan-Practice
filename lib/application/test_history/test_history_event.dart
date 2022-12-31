part of 'test_history_bloc.dart';

abstract class TestHistoryEvent extends Equatable {
  const TestHistoryEvent();

  @override
  List<Object> get props => [];
}

class TestHistoryEventLoading extends TestHistoryEvent {
  final DateTime initial;
  final DateTime last;
  final TestFilters testFilter;
  final TestModeFilters modesFilter;

  const TestHistoryEventLoading({
    required this.initial,
    required this.last,
    this.testFilter = TestFilters.all,
    this.modesFilter = TestModeFilters.all,
  });

  @override
  List<Object> get props => [initial, last, testFilter, modesFilter];
}

class TestHistoryEventRemoving extends TestHistoryEvent {}
