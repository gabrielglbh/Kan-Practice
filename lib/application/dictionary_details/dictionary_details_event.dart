part of 'dictionary_details_bloc.dart';

abstract class DictionaryDetailsEvent extends Equatable {
  const DictionaryDetailsEvent();

  @override
  List<Object> get props => [];
}

class DictionaryDetailsLoadingEvent extends DictionaryDetailsEvent {
  final String word;

  const DictionaryDetailsLoadingEvent({required this.word});

  @override
  List<Object> get props => [word];
}

class DictionaryDetailsEventAddToHistory extends DictionaryDetailsEvent {
  final String word;

  const DictionaryDetailsEventAddToHistory({required this.word});

  @override
  List<Object> get props => [word];
}
