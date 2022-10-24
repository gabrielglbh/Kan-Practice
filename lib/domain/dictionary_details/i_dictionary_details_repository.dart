import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:unofficial_jisho_api/api.dart';

abstract class IDictionaryDetailsRepository {
  Future<KanjiResultData?> searchWord(String word);
  Future<List<JishoResult>> searchPhrase(String word);
  Future<List<WordExample>> searchForExample(String word);
}
