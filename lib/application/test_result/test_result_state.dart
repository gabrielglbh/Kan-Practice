part of 'test_result_bloc.dart';

abstract class TestResultState extends Equatable {
  const TestResultState();

  @override
  List<Object> get props => [];
}

class TestResultStateIdle extends TestResultState {}

class TestResultStateSaved extends TestResultState {}

class TestResultStateSaving extends TestResultState {}
