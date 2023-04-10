part of 'list_details_words_bloc.dart';

abstract class ListDetailsWordsEvent extends Equatable {
  const ListDetailsWordsEvent();

  @override
  List<Object> get props => [];
}

class ListDetailsWordsEventLoading extends ListDetailsWordsEvent {
  final String list;
  final bool reset;

  const ListDetailsWordsEventLoading(this.list, {this.reset = false});

  @override
  List<Object> get props => [list, reset];
}

class ListDetailsWordsEventSearching extends ListDetailsWordsEvent {
  final String query;
  final String list;
  final bool reset;

  const ListDetailsWordsEventSearching(this.query, this.list,
      {this.reset = false});

  @override
  List<Object> get props => [query, list, reset];
}

class ListDetailsWordsEventLoadUpPractice extends ListDetailsWordsEvent {
  final StudyModes studyMode;
  final String list;

  const ListDetailsWordsEventLoadUpPractice(this.list, this.studyMode);

  @override
  List<Object> get props => [list, studyMode];
}
