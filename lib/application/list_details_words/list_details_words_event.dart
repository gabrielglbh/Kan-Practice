part of 'list_details_words_bloc.dart';

abstract class ListDetailWordsEvent extends Equatable {
  const ListDetailWordsEvent();

  @override
  List<Object> get props => [];
}

class ListDetailWordsEventLoading extends ListDetailWordsEvent {
  final String list;
  final bool reset;

  const ListDetailWordsEventLoading(this.list, {this.reset = false});

  @override
  List<Object> get props => [list, reset];
}

class ListDetailWordsEventSearching extends ListDetailWordsEvent {
  final String query;
  final String list;
  final bool reset;

  const ListDetailWordsEventSearching(this.query, this.list,
      {this.reset = false});

  @override
  List<Object> get props => [query, list, reset];
}

class ListDetailWordsEventLoadUpPractice extends ListDetailWordsEvent {
  final StudyModes studyMode;
  final String list;

  const ListDetailWordsEventLoadUpPractice(this.list, this.studyMode);

  @override
  List<Object> get props => [list, studyMode];
}
