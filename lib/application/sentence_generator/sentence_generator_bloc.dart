import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/sentence_generator/i_sentence_generator_repository.dart';

part 'sentence_generator_event.dart';
part 'sentence_generator_state.dart';

part 'sentence_generator_bloc.freezed.dart';

@lazySingleton
class SentenceGeneratorBloc
    extends Bloc<SentenceGeneratorEvent, SentenceGeneratorState> {
  final ISentenceGeneratorRepository _sentenceGeneratorRepository;

  SentenceGeneratorBloc(this._sentenceGeneratorRepository)
      : super(const SentenceGeneratorState.initial()) {
    on<SentenceGeneratorEventReset>(((event, emit) {
      emit(const SentenceGeneratorState.initial());
    }));

    on<SentenceGeneratorEventLoad>((event, emit) async {
      emit(const SentenceGeneratorState.loading());
      final sentence =
          await _sentenceGeneratorRepository.getRandomSentence(event.words);
      if (sentence.isNotEmpty) {
        emit(SentenceGeneratorState.succeeded(sentence));
      } else {
        emit(const SentenceGeneratorState.error());
      }
    });
  }
}
