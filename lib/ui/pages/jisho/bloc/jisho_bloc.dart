import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/jisho/JishoAPI.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

part 'jisho_event.dart';
part 'jisho_state.dart';

class JishoBloc extends Bloc<JishoEvent, JishoState> {
  JishoBloc() : super(JishoStateLoading()) {
    on<JishoLoadingEvent>((event, emit) async {
      emit(JishoStateLoading());
      jisho.KanjiResultData? resultData = await JishoAPI.instance.searchKanji(event.kanji);
      List<KanjiExample> example = await JishoAPI.instance.searchForExample(event.kanji);
      KanjiData data = KanjiData(resultData: resultData, example: example);
      emit(JishoStateLoaded(data: data));
    });
  }
}