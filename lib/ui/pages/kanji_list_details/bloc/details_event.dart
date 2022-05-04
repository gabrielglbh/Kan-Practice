part of 'details_bloc.dart';

abstract class KanjiListDetailEvent extends Equatable {
  const KanjiListDetailEvent();

  @override
  List<Object> get props => [];
}

class KanjiEventLoading extends KanjiListDetailEvent {
  final String list;
  final bool reset;

  const KanjiEventLoading(this.list, {this.reset = false});

  @override
  List<Object> get props => [list, reset];
}

class KanjiEventSearching extends KanjiListDetailEvent {
  final String query;
  final String list;
  final bool reset;

  const KanjiEventSearching(this.query, this.list, {this.reset = false});

  @override
  List<Object> get props => [query, list, reset];
}

class KanjiEventLoadUpPractice extends KanjiListDetailEvent {
  final LearningMode mode;
  final StudyModes studyMode;
  final String list;

  const KanjiEventLoadUpPractice(this.mode, this.list, this.studyMode);

  @override
  List<Object> get props => [mode, list, studyMode];
}

class UpdateKanList extends KanjiListDetailEvent {
  final String name;
  final String og;

  const UpdateKanList(this.name, this.og);

  @override
  List<Object> get props => [name, og];
}