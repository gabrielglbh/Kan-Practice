import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:unofficial_jisho_api/api.dart';

class WordData {
  final KanjiResultData? resultData;
  final List<JishoResult> resultPhrase;
  final List<WordExample> example;

  const WordData(
      {required this.resultData,
      required this.resultPhrase,
      required this.example});
}
