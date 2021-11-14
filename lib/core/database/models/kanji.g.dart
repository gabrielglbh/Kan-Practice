// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kanji _$KanjiFromJson(Map<String, dynamic> json) {
  return Kanji(
    kanji: json['kanji'] as String,
    listName: json['name'] as String,
    meaning: json['meaning'] as String,
    pronunciation: json['pronunciation'] as String,
    winRateReading: (json['winRateReading'] as num).toDouble(),
    winRateRecognition: (json['winRateRecognition'] as num).toDouble(),
    winRateWriting: (json['winRateWriting'] as num).toDouble(),
    dateAdded: json['dateAdded'] as int,
  );
}

Map<String, dynamic> _$KanjiToJson(Kanji instance) => <String, dynamic>{
      'kanji': instance.kanji,
      'name': instance.listName,
      'meaning': instance.meaning,
      'pronunciation': instance.pronunciation,
      'winRateWriting': instance.winRateWriting,
      'winRateReading': instance.winRateReading,
      'winRateRecognition': instance.winRateRecognition,
      'dateAdded': instance.dateAdded,
    };
