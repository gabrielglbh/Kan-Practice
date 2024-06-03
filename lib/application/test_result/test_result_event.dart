part of 'test_result_bloc.dart';

abstract class TestResultEvent extends Equatable {
  const TestResultEvent();

  @override
  List<Object> get props => [];
}

class TestResultEventSaveTest extends TestResultEvent {
  final Test test;
  final double elapsedTimeSecondsPerCard;

  const TestResultEventSaveTest(
      {required this.test, required this.elapsedTimeSecondsPerCard});
}
