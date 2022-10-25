part of 'list_details_bloc.dart';

abstract class ListDetailEvent extends Equatable {
  const ListDetailEvent();

  @override
  List<Object> get props => [];
}

class ListDetailEventLoading extends ListDetailEvent {
  final String list;
  final bool reset;

  const ListDetailEventLoading(this.list, {this.reset = false});

  @override
  List<Object> get props => [list, reset];
}

class ListDetailEventSearching extends ListDetailEvent {
  final String query;
  final String list;
  final bool reset;

  const ListDetailEventSearching(this.query, this.list, {this.reset = false});

  @override
  List<Object> get props => [query, list, reset];
}

class ListDetailEventLoadUpPractice extends ListDetailEvent {
  final StudyModes studyMode;
  final String list;

  const ListDetailEventLoadUpPractice(this.list, this.studyMode);

  @override
  List<Object> get props => [list, studyMode];
}

class ListDetailUpdateName extends ListDetailEvent {
  final String name;
  final String og;

  const ListDetailUpdateName(this.name, this.og);

  @override
  List<Object> get props => [name, og];
}
