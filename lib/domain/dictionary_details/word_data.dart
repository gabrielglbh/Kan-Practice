import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

class WordData {
  final jisho.KanjiResultData? resultData;
  final List<jisho.JishoResult> resultPhrase;
  final List<WordExample> example;

  const WordData(
      {required this.resultData,
      required this.resultPhrase,
      required this.example});
}
