// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanjiList _$KanjiListFromJson(Map<String, dynamic> json) {
  return KanjiList(
    name: json['name'] as String,
    totalWinRateWriting: (json['totalWinRateWriting'] as num).toDouble(),
    totalWinRateReading: (json['totalWinRateReading'] as num).toDouble(),
    totalWinRateRecognition:
        (json['totalWinRateRecognition'] as num).toDouble(),
    lastUpdated: json['lastUpdated'] as int,
  );
}

Map<String, dynamic> _$KanjiListToJson(KanjiList instance) => <String, dynamic>{
      'name': instance.name,
      'totalWinRateWriting': instance.totalWinRateWriting,
      'totalWinRateReading': instance.totalWinRateReading,
      'totalWinRateRecognition': instance.totalWinRateRecognition,
      'lastUpdated': instance.lastUpdated,
    };
