part of 'sentence_generator_bloc.dart';

abstract class SentenceGeneratorEvent extends Equatable {
  const SentenceGeneratorEvent();

  @override
  List<Object> get props => [];
}

class SentenceGeneratorEventLoad extends SentenceGeneratorEvent {
  final int hash;
  final String? locale;
  final List<String>? words;

  const SentenceGeneratorEventLoad({this.hash = 0, this.locale, this.words});

  @override
  List<Object> get props => [hash];
}

class SentenceGeneratorEventReset extends SentenceGeneratorEvent {}
