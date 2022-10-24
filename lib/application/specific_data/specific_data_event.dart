part of 'specific_data_bloc.dart';

abstract class SpecificDataEvent extends Equatable {
  const SpecificDataEvent();

  @override
  List<Object> get props => [];
}

class SpecificDataEventGatherTest extends SpecificDataEvent {
  final Tests test;

  const SpecificDataEventGatherTest({required this.test});
}

class SpecificDataEventGatherCategory extends SpecificDataEvent {
  final WordCategory category;

  const SpecificDataEventGatherCategory({required this.category});
}
