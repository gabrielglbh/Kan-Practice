part of 'dictionary_details_bloc.dart';

abstract class DictionaryDetailsEvent extends Equatable {
  const DictionaryDetailsEvent();

  @override
  List<Object> get props => [];
}

class DictionaryDetailsLoadingEvent extends DictionaryDetailsEvent {
  final String kanji;

  const DictionaryDetailsLoadingEvent({required this.kanji});

  @override
  List<Object> get props => [kanji];
}

class DictionaryDetailsEventAddToHistory extends DictionaryDetailsEvent {
  final String word;

  const DictionaryDetailsEventAddToHistory({required this.word});

  @override
  List<Object> get props => [word];
}
