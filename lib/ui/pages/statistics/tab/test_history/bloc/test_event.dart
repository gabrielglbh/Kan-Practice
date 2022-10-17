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

  const TestListEventLoading({required this.initial, required this.last});

  @override
  List<Object> get props => [initial, last];
}

class TestListEventRemoving extends TestListEvent {}
