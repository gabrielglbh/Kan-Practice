import 'package:unofficial_jisho_api/api.dart' as jisho;

class KanjiData {
  final jisho.KanjiResultData? resultData;
  final List<jisho.JishoResult> resultPhrase;
  final List<KanjiExample> example;

  const KanjiData({required this.resultData, required this.resultPhrase,
    required this.example});
}

class KanjiExample {
  final String? kanji;
  final String? kana;
  final String? english;
  final String? jishoUri;

  const KanjiExample({this.kanji, this.kana, this.english, this.jishoUri});
}