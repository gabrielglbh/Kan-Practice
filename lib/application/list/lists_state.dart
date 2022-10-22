part of 'lists_bloc.dart';

class ListState extends Equatable {
  const ListState();

  @override
  List<Object?> get props => [];
}

class ListStateLoading extends ListState {}

class ListStateSearching extends ListState {}

class ListStateLoaded extends ListState {
  final List<KanjiList> lists;

  const ListStateLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class ListStateFailure extends ListState {}
