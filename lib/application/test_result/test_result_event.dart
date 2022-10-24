part of 'test_result_bloc.dart';

abstract class TestResultEvent extends Equatable {
  const TestResultEvent();

  @override
  List<Object> get props => [];
}

class TestResultEventSaveTest extends TestResultEvent {
  final Test test;

  const TestResultEventSaveTest({required this.test});
}
