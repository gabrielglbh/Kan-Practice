part of 'test_bloc.dart';

abstract class TestListEvent extends Equatable {
  const TestListEvent();

  @override
  List<Object> get props => [];
}

class TestListEventLoading extends TestListEvent {}

class TestListEventRemoving extends TestListEvent {}