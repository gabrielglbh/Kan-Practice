part of 'list_details_bloc.dart';

class ListDetailState extends Equatable {
  const ListDetailState();

  @override
  List<Object?> get props => [];
}

class ListDetailStateLoading extends ListDetailState {}

class ListDetailStateSearching extends ListDetailState {}

class ListDetailStateLoadedPractice extends ListDetailState {
  final StudyModes mode;
  final List<Kanji> list;

  const ListDetailStateLoadedPractice(this.mode, this.list);

  @override
  List<Object> get props => [list, mode];
}

class ListDetailStateLoaded extends ListDetailState {
  final List<Kanji> list;
  final String name;

  const ListDetailStateLoaded(this.list, this.name);

  @override
  List<Object> get props => [list, name];
}

class ListDetailStateFailure extends ListDetailState {
  final String error;

  const ListDetailStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
