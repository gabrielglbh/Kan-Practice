import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/dictionary_details/i_dictionary_details_repository.dart';
import 'package:kanpractice/domain/dictionary_details/word_data.dart';
import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:kanpractice/domain/word_history/i_word_history_repository.dart';
import 'package:unofficial_jisho_api/api.dart';

part 'dictionary_details_event.dart';
part 'dictionary_details_state.dart';

part 'dictionary_details_bloc.freezed.dart';

@lazySingleton
class DictionaryDetailsBloc
    extends Bloc<DictionaryDetailsEvent, DictionaryDetailsState> {
  final IDictionaryDetailsRepository _dictionaryDetailsRepository;
  final IWordHistoryRepository _wordHistoryRepository;

  DictionaryDetailsBloc(
    this._dictionaryDetailsRepository,
    this._wordHistoryRepository,
  ) : super(const DictionaryDetailsState.initial()) {
    on<DictionaryDetailsLoadingEvent>((event, emit) async {
      emit(const DictionaryDetailsState.loading());
      try {
        final infra = _dictionaryDetailsRepository;
        KanjiResultData? resultData = await infra.searchWord(event.word);
        List<JishoResult> resultPhrase = await infra.searchPhrase(event.word);
        List<WordExample> example = await infra.searchForExample(event.word);

        WordData data = WordData(
            resultData: resultData,
            resultPhrase: resultPhrase,
            example: example);
        if (data.resultData == null && data.example.isEmpty) {
          emit(const DictionaryDetailsState.error());
        } else {
          emit(DictionaryDetailsState.loaded(data));
        }
      } on Exception {
        emit(const DictionaryDetailsState.error());
      }
    });

    on<DictionaryDetailsEventAddToHistory>((event, emit) async {
      await _wordHistoryRepository.addWordToHistory(event.word);
    });
  }
}
