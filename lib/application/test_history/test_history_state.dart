part of 'test_history_bloc.dart';

class TestHistoryState extends Equatable {
  const TestHistoryState();

  @override
  List<Object?> get props => [];
}

class TestHistoryStateIdle extends TestHistoryState {}

class TestHistoryStateLoading extends TestHistoryState {}

class TestHistoryStateLoaded extends TestHistoryState {
  final List<Test> list;

  const TestHistoryStateLoaded([this.list = const []]);

  @override
  List<Object> get props => [list];
}

class TestHistoryStateFailure extends TestHistoryState {}
