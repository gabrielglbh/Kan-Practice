import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/dictionary_details/i_dictionary_details_repository.dart';
import 'package:unofficial_jisho_api/api.dart';
import 'package:kanpractice/domain/dictionary_details/word_example.dart';

@LazySingleton(as: IDictionaryDetailsRepository)
class DictionaryDetailsRepositoryImpl implements IDictionaryDetailsRepository {
  @override
  Future<List<WordExample>> searchForExample(String word) async {
    ExampleResults res = await searchForExamples(word);
    List<WordExample> examples = [];
    for (var example in res.results) {
      examples.add(WordExample(
          word: example.kanji,
          kana: example.kana,
          english: example.english,
          jishoUri: res.uri));
    }
    return examples;
  }

  @override
  Future<List<JishoResult>> searchPhrase(String word) async {
    JishoAPIResult res = await searchForPhrase(word);
    List<JishoResult>? resData = res.data;
    List<JishoResult> data = [];
    if (resData != null) data = resData;
    return data;
  }

  @override
  Future<KanjiResultData?> searchWord(String word) async {
    KanjiResult res = await searchForKanji(word);
    return res.data;
  }
}
