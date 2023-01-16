import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/dictionary_details/i_dictionary_details_repository.dart';
import 'package:kanpractice/domain/dictionary_details/word_data.dart';
import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:kanpractice/domain/word_history/i_word_history_repository.dart';
import 'package:unofficial_jisho_api/api.dart';

part 'dictionary_details_event.dart';
part 'dictionary_details_state.dart';

@lazySingleton
class DictionaryDetailsBloc
    extends Bloc<DictionaryDetailsEvent, DictionaryDetailsState> {
  final IDictionaryDetailsRepository _dictionaryDetailsRepository;
  final IWordHistoryRepository _wordHistoryRepository;

  DictionaryDetailsBloc(
    this._dictionaryDetailsRepository,
    this._wordHistoryRepository,
  ) : super(DictionaryDetailsStateIdle()) {
    on<DictionaryDetailsLoadingEvent>((event, emit) async {
      emit(DictionaryDetailsStateLoading());
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
          emit(DictionaryDetailsStateFailure());
        } else {
          emit(DictionaryDetailsStateLoaded(data: data));
        }
      } on Exception {
        emit(DictionaryDetailsStateFailure());
      }
    });

    on<DictionaryDetailsEventAddToHistory>((event, emit) async {
      await _wordHistoryRepository.addWordToHistory(event.word);
    });
  }
}
