import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';

part 'daily_options_event.dart';
part 'daily_options_state.dart';

part 'daily_options_bloc.freezed.dart';

@lazySingleton
class DailyOptionsBloc extends Bloc<DailyOptionsEvent, DailyOptionsState> {
  final IWordRepository _wordRepository;
  final IGrammarPointRepository _grammarPointRepository;
  final IPreferencesRepository _preferencesRepository;

  DailyOptionsBloc(this._wordRepository, this._grammarPointRepository,
      this._preferencesRepository)
      : super(const DailyOptionsState.initial()) {
    on<DailyOptionsEventLoadData>((event, emit) async {
      try {
        emit(const DailyOptionsState.loading());
        final words = (await _wordRepository.getAllWords()).length;
        final wordsMean = (words / 7).ceil();
        final grammar =
            (await _grammarPointRepository.getAllGrammarPoints()).length;
        final grammarMean = (grammar / 7).ceil();

        if (_preferencesRepository.readData(SharedKeys.maxWordsOnDaily) ==
            null) {
          _preferencesRepository.saveData(
              SharedKeys.maxWordsOnDaily, wordsMean);
        }
        if (_preferencesRepository.readData(SharedKeys.maxGrammarOnDaily) ==
            null) {
          _preferencesRepository.saveData(
              SharedKeys.maxGrammarOnDaily, grammarMean);
        }

        emit(DailyOptionsState.loaded(words, grammar, wordsMean, grammarMean));
      } on Exception {
        emit(const DailyOptionsState.error());
      }
    });
  }
}
