part of 'list_details_bloc.dart';

abstract class ListDetailEvent extends Equatable {
  const ListDetailEvent();

  @override
  List<Object> get props => [];
}

class ListDetailEventIdle extends ListDetailEvent {
  final String name;

  const ListDetailEventIdle(this.name);
}

class ListDetailUpdateName extends ListDetailEvent {
  final String name;
  final String og;

  const ListDetailUpdateName(this.name, this.og);

  @override
  List<Object> get props => [name, og];
}
