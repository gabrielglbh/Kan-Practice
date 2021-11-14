part of 'details_bloc.dart';

class KanjiListDetailState extends Equatable {
  const KanjiListDetailState();

  @override
  List<Object?> get props => [];
}

class KanjiListDetailStateLoading extends KanjiListDetailState {}

class KanjiListDetailStateLoaded extends KanjiListDetailState {
  final List<Kanji> list;
  final String name;

  const KanjiListDetailStateLoaded(this.list, this.name);

  @override
  List<Object> get props => [list, name];
}

class KanjiListDetailStateFailure extends KanjiListDetailState {}