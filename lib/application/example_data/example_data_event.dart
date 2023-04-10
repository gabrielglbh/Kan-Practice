part of 'example_data_bloc.dart';

abstract class ExampleDataEvent extends Equatable {
  const ExampleDataEvent();

  @override
  List<Object> get props => [];
}

class ExampleDataEventIdle extends ExampleDataEvent {}

class ExampleDataEventInstallData extends ExampleDataEvent {
  final BuildContext context;

  const ExampleDataEventInstallData(this.context);

  @override
  List<Object> get props => [context];
}
