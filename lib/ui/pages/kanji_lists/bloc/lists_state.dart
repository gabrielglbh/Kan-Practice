part of 'lists_bloc.dart';

class KanjiListState extends Equatable {
  const KanjiListState();

  @override
  List<Object?> get props => [];
}

class KanjiListStateLoading extends KanjiListState {}

class KanjiListStateSearching extends KanjiListState {}

class KanjiListStateLoaded extends KanjiListState {
  final List<KanjiList> lists;

  const KanjiListStateLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class KanjiListStateFailure extends KanjiListState {}