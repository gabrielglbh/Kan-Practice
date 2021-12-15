import 'package:json_annotation/json_annotation.dart';

part 'jisho_data.g.dart';

@JsonSerializable()
class KanjiExample {
  final String? kanji;
  final String? kana;
  final String? english;
  final String? jishoUri;

  const KanjiExample({this.kanji, this.kana, this.english, this.jishoUri});

  factory KanjiExample.fromJson(Map<String, dynamic> json) => _$KanjiExampleFromJson(json);
}