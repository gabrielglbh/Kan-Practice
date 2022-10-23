import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/queries/word_history_queries.dart';
import 'package:kanpractice/core/jisho/jisho_api.dart';
import 'package:kanpractice/domain/dictionary_details/word_data.dart';
import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

part 'dictionary_details_event.dart';
part 'dictionary_details_state.dart';

class DictionaryDetailsBloc
    extends Bloc<DictionaryDetailsEvent, DictionaryDetailsState> {
  DictionaryDetailsBloc() : super(DictionaryDetailsStateLoading()) {
    on<DictionaryDetailsLoadingEvent>((event, emit) async {
      emit(DictionaryDetailsStateLoading());
      try {
        jisho.KanjiResultData? resultData =
            await JishoAPI.instance.searchKanji(event.kanji);
        List<jisho.JishoResult> resultPhrase =
            await JishoAPI.instance.searchPhrase(event.kanji);
        List<WordExample> example =
            await JishoAPI.instance.searchForExample(event.kanji);

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
      await WordHistoryQueries.instance.createWord(event.word);
    });
  }
}
