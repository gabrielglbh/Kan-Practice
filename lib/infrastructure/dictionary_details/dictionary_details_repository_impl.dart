import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/dictionary_details/i_dictionary_details_repository.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;
import 'package:kanpractice/domain/dictionary_details/word_example.dart';

@LazySingleton(as: IDictionaryDetailsRepository)
class DictionaryDetailsRepositoryImpl implements IDictionaryDetailsRepository {
  @override
  Future<List<WordExample>> searchForExample(String word) async {
    jisho.ExampleResults res = await jisho.searchForExamples(word);
    List<WordExample> examples = [];
    for (var example in res.results) {
      examples.add(WordExample(
          kanji: example.kanji,
          kana: example.kana,
          english: example.english,
          jishoUri: res.uri));
    }
    return examples;
  }

  @override
  Future<List<jisho.JishoResult>> searchPhrase(String word) async {
    jisho.JishoAPIResult res = await jisho.searchForPhrase(word);
    List<jisho.JishoResult>? resData = res.data;
    List<jisho.JishoResult> data = [];
    if (resData != null) data = resData;
    return data;
  }

  @override
  Future<jisho.KanjiResultData?> searchWord(String word) async {
    jisho.KanjiResult res = await jisho.searchForKanji(word);
    return res.data;
  }
}
