part of 'specific_data_bloc.dart';

abstract class SpecificDataState extends Equatable {
  const SpecificDataState();

  @override
  List<Object> get props => [];
}

class SpecificDataStateIdle extends SpecificDataState {}

class SpecificDataStateGatheredCategory extends SpecificDataState {
  final SpecificData data;
  final WordCategory category;

  const SpecificDataStateGatheredCategory(this.data, this.category);

  @override
  List<Object> get props => [data, category];
}

class SpecificDataStateGatheredTest extends SpecificDataState {
  final SpecificData data;
  final Tests test;

  const SpecificDataStateGatheredTest(this.data, this.test);

  @override
  List<Object> get props => [data, test];
}
