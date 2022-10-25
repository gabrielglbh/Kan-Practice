part of 'initial_bloc.dart';

abstract class InitialEvent extends Equatable {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

class InitialEventIdle extends InitialEvent {}

class InitialEventInstallData extends InitialEvent {
  final BuildContext context;

  const InitialEventInstallData(this.context);

  @override
  List<Object> get props => [context];
}
