import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

class JishoAPI {
  /// Singleton instance of [JishoAPI]
  static JishoAPI instance = JishoAPI();

  Future<jisho.KanjiResultData?> searchKanji(Kanji? kanji) async {
    if (kanji != null) {
      jisho.KanjiResult res = await jisho.searchForKanji(kanji.kanji);
      return res.data;
    }
    return null;
  }

  Future<List<KanjiExample>> searchForExample(Kanji? kanji) async {
    if (kanji != null) {
      jisho.ExampleResults res = await jisho.searchForExamples(kanji.kanji);
      List<KanjiExample> examples = [];
      res.results.forEach((example) {
        examples.add(KanjiExample(
          kanji: example.kanji,
          kana: example.kana,
          english: example.english,
          jishoUri: res.uri
        ));
      });
      return examples;
    }
    return [];
  }
}