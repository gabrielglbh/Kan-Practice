part of 'details_bloc.dart';

class KanjiListDetailState extends Equatable {
  const KanjiListDetailState();

  @override
  List<Object?> get props => [];
}

class KanjiListDetailStateLoading extends KanjiListDetailState {}

class KanjiListDetailStateSearching extends KanjiListDetailState {}

class KanjiListDetailStateLoadedPractice extends KanjiListDetailState {
  final StudyModes mode;
  final List<Kanji> list;
  final LearningMode lMode;

  const KanjiListDetailStateLoadedPractice(this.mode, this.list, this.lMode);

  @override
  List<Object> get props => [list, mode, lMode];
}

class KanjiListDetailStateLoaded extends KanjiListDetailState {
  final List<Kanji> list;
  final String name;

  const KanjiListDetailStateLoaded(this.list, this.name);

  @override
  List<Object> get props => [list, name];
}

class KanjiListDetailStateFailure extends KanjiListDetailState {
  final String error;

  const KanjiListDetailStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
