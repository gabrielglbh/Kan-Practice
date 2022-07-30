// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanjiList _$KanjiListFromJson(Map<String, dynamic> json) => KanjiList(
      name: json['name'] as String,
      folder: json['folder'] as String?,
      totalWinRateWriting: (json['totalWinRateWriting'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      totalWinRateReading: (json['totalWinRateReading'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      totalWinRateRecognition:
          (json['totalWinRateRecognition'] as num?)?.toDouble() ??
              DatabaseConstants.emptyWinRate,
      totalWinRateListening:
          (json['totalWinRateListening'] as num?)?.toDouble() ??
              DatabaseConstants.emptyWinRate,
      lastUpdated: json['lastUpdated'] as int,
    );

Map<String, dynamic> _$KanjiListToJson(KanjiList instance) => <String, dynamic>{
      'name': instance.name,
      'folder': instance.folder,
      'totalWinRateWriting': instance.totalWinRateWriting,
      'totalWinRateReading': instance.totalWinRateReading,
      'totalWinRateRecognition': instance.totalWinRateRecognition,
      'totalWinRateListening': instance.totalWinRateListening,
      'lastUpdated': instance.lastUpdated,
    };
