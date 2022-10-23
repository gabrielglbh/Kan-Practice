import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/dictionary_details/word_data.dart';
import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:kanpractice/infrastructure/dictionary_details/dictionary_details_repository_impl.dart';
import 'package:kanpractice/infrastructure/word_history/word_history_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

part 'dictionary_details_event.dart';
part 'dictionary_details_state.dart';

@lazySingleton
class DictionaryDetailsBloc
    extends Bloc<DictionaryDetailsEvent, DictionaryDetailsState> {
  DictionaryDetailsBloc() : super(DictionaryDetailsStateLoading()) {
    on<DictionaryDetailsLoadingEvent>((event, emit) async {
      emit(DictionaryDetailsStateLoading());
      try {
        final infra = getIt<DictionaryDetailsRepositoryImpl>();
        jisho.KanjiResultData? resultData = await infra.searchWord(event.kanji);
        List<jisho.JishoResult> resultPhrase =
            await infra.searchPhrase(event.kanji);
        List<WordExample> example = await infra.searchForExample(event.kanji);

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
      await getIt<WordHistoryRepositoryImpl>().addWordToHistory(event.word);
    });
  }
}
