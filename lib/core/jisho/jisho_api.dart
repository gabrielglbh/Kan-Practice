import 'package:kanpractice/domain/dictionary_details/dictionary_details_example.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

class JishoAPI {
  JishoAPI._();

  static final JishoAPI _instance = JishoAPI._();

  /// Singleton instance of [JishoAPI]
  static JishoAPI get instance => _instance;

  Future<jisho.KanjiResultData?> searchKanji(String kanji) async {
    jisho.KanjiResult res = await jisho.searchForKanji(kanji);
    return res.data;
  }

  Future<List<jisho.JishoResult>> searchPhrase(String kanji) async {
    jisho.JishoAPIResult res = await jisho.searchForPhrase(kanji);
    List<jisho.JishoResult>? resData = res.data;
    List<jisho.JishoResult> data = [];
    if (resData != null) data = resData;
    return data;
  }

  Future<List<KanjiExample>> searchForExample(String kanji) async {
    jisho.ExampleResults res = await jisho.searchForExamples(kanji);
    List<KanjiExample> examples = [];
    for (var example in res.results) {
      examples.add(KanjiExample(
          kanji: example.kanji,
          kana: example.kana,
          english: example.english,
          jishoUri: res.uri));
    }
    return examples;
  }
}
