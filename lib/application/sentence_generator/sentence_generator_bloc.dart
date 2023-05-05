import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/sentence_generator/i_sentence_generator_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';

part 'sentence_generator_event.dart';
part 'sentence_generator_state.dart';

part 'sentence_generator_bloc.freezed.dart';

@lazySingleton
class SentenceGeneratorBloc
    extends Bloc<SentenceGeneratorEvent, SentenceGeneratorState> {
  final ISentenceGeneratorRepository _sentenceGeneratorRepository;
  final IWordRepository _wordRepository;

  SentenceGeneratorBloc(
    this._sentenceGeneratorRepository,
    this._wordRepository,
  ) : super(const SentenceGeneratorState.initial()) {
    on<SentenceGeneratorEventReset>(((event, emit) {
      emit(const SentenceGeneratorState.initial());
    }));

    on<SentenceGeneratorEventLoad>((event, emit) async {
      emit(const SentenceGeneratorState.loading());
      final bag = <Word>[];
      if (event.words == null) {
        for (var c in WordCategory.values) {
          bag.add(await _wordRepository.getRandomWord(c.index));
        }
        bag.shuffle();
      }

      final sentence = await _sentenceGeneratorRepository.getRandomSentence(
        event.words != null
            ? event.words!
            : bag.sublist(0, 3).map((value) => value.word).toList(),
      );
      if (sentence.isNotEmpty) {
        emit(SentenceGeneratorState.succeeded(sentence));
      } else {
        emit(const SentenceGeneratorState.error());
      }
    });
  }
}
