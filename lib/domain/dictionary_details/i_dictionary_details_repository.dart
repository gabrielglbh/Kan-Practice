import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

abstract class IDictionaryDetailsRepository {
  Future<jisho.KanjiResultData?> searchWord(String word);
  Future<List<jisho.JishoResult>> searchPhrase(String word);
  Future<List<WordExample>> searchForExample(String word);
}
