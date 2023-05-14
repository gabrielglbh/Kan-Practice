import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';
import 'package:kanpractice/domain/sentence_generator/i_sentence_generator_repository.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';
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
  final ITranslateRepository _translateRepository;
  final IAuthRepository _authRepository;

  SentenceGeneratorBloc(
    this._sentenceGeneratorRepository,
    this._wordRepository,
    this._translateRepository,
    this._authRepository,
  ) : super(const SentenceGeneratorState.initial()) {
    on<SentenceGeneratorEventReset>(((event, emit) {
      _translateRepository.close();
      emit(const SentenceGeneratorState.initial());
    }));

    on<SentenceGeneratorEventLoad>((event, emit) async {
      emit(const SentenceGeneratorState.loading());
      final uid = _authRepository.getUser()?.uid;
      if (uid == null) return emit(const SentenceGeneratorState.error());

      final List<Word> bag = [];
      final List<String> usedWords = [];
      if (event.words == null) {
        for (var c in WordCategory.values) {
          final word = await _wordRepository.getRandomWord(c.index);
          if (word != Word.empty) bag.add(word);
        }
        bag.shuffle();
      }

      usedWords.addAll(bag
          .sublist(0, bag.length > 3 ? 3 : bag.length)
          .map((value) => value.word)
          .toList());

      final sentence = await _sentenceGeneratorRepository.getRandomSentence(
        uid,
        event.words != null ? event.words! : usedWords,
      );

      if (sentence.isNotEmpty) {
        String translation = '';
        if (event.locale != null) {
          translation = await _translateRepository.translate(
            sentence,
            event.locale!,
          );
        }
        emit(SentenceGeneratorState.succeeded(
          sentence,
          translation,
          usedWords,
        ));
      } else {
        emit(const SentenceGeneratorState.error());
      }
    });
  }
}
