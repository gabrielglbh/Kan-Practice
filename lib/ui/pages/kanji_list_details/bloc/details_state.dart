part of 'details_bloc.dart';

class KanjiListDetailState extends Equatable {
  const KanjiListDetailState();

  @override
  List<Object?> get props => [];
}

class KanjiListDetailStateLoading extends KanjiListDetailState {}

class KanjiListDetailStateLoaded extends KanjiListDetailState {
  final List<Kanji> list;

  const KanjiListDetailStateLoaded([this.list = const []]);

  @override
  List<Object> get props => [list];
}

class KanjiListDetailStateFailure extends KanjiListDetailState {}