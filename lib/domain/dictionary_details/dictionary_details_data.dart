import 'package:kanpractice/domain/dictionary_details/dictionary_details_example.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

class KanjiData {
  final jisho.KanjiResultData? resultData;
  final List<jisho.JishoResult> resultPhrase;
  final List<KanjiExample> example;

  const KanjiData(
      {required this.resultData,
      required this.resultPhrase,
      required this.example});
}
