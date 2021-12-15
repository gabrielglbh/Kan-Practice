// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jisho_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanjiExample _$KanjiExampleFromJson(Map<String, dynamic> json) => KanjiExample(
      kanji: json['kanji'] as String?,
      kana: json['kana'] as String?,
      english: json['english'] as String?,
      jishoUri: json['jishoUri'] as String?,
    );

Map<String, dynamic> _$KanjiExampleToJson(KanjiExample instance) =>
    <String, dynamic>{
      'kanji': instance.kanji,
      'kana': instance.kana,
      'english': instance.english,
      'jishoUri': instance.jishoUri,
    };
