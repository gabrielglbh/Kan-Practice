part of 'test_bloc.dart';

class TestListState extends Equatable {
  const TestListState();

  @override
  List<Object?> get props => [];
}

class TestListStateLoading extends TestListState {}

class TestListStateLoaded extends TestListState {
  final List<Test> list;

  const TestListStateLoaded([this.list = const []]);

  @override
  List<Object> get props => [list];
}

class TestListStateFailure extends TestListState {}
