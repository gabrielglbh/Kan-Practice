part of 'initial_bloc.dart';

abstract class InitialState extends Equatable {
  const InitialState();

  @override
  List<Object> get props => [];
}

class InitialInitial extends InitialState {}

class InitialStateSuccess extends InitialState {}

class InitialStateFailure extends InitialState {
  final String message;

  const InitialStateFailure(this.message);

  @override
  List<Object> get props => [message];
}
