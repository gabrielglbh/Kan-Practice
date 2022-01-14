part of 'test_bloc.dart';

abstract class TestListEvent extends Equatable {
  const TestListEvent();

  @override
  List<Object> get props => [];
}

class TestListEventLoading extends TestListEvent {
  final int offset;

  const TestListEventLoading({this.offset = 0});

  @override
  List<Object> get props => [offset];
}

class TestListEventRemoving extends TestListEvent {}