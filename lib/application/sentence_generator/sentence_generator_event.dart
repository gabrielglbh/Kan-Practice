part of 'sentence_generator_bloc.dart';

abstract class SentenceGeneratorEvent extends Equatable {
  const SentenceGeneratorEvent();

  @override
  List<Object> get props => [];
}

class SentenceGeneratorEventLoad extends SentenceGeneratorEvent {
  final List<String> words;

  const SentenceGeneratorEventLoad(this.words);

  @override
  List<Object> get props => [words];
}

class SentenceGeneratorEventReset extends SentenceGeneratorEvent {}
