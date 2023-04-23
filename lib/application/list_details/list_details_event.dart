part of 'list_details_bloc.dart';

abstract class ListDetailsEvent extends Equatable {
  const ListDetailsEvent();

  @override
  List<Object> get props => [];
}

class ListDetailsEventIdle extends ListDetailsEvent {
  final String name;

  const ListDetailsEventIdle(this.name);
}

class ListDetailsUpdateName extends ListDetailsEvent {
  final String name;
  final String og;

  const ListDetailsUpdateName(this.name, this.og);

  @override
  List<Object> get props => [name, og];
}
