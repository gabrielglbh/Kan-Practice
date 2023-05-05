part of 'alter_specific_data_bloc.dart';

abstract class AlterSpecificDataEvent extends Equatable {
  const AlterSpecificDataEvent();

  @override
  List<Object> get props => [];
}

class AlterSpecificDataEventGatherTest extends AlterSpecificDataEvent {
  final Tests test;

  const AlterSpecificDataEventGatherTest({required this.test});
}
