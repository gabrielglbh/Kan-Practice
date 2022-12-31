// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordList _$WordListFromJson(Map<String, dynamic> json) => WordList(
      name: json['name'] as String,
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
      totalWinRateSpeaking:
          (json['totalWinRateSpeaking'] as num?)?.toDouble() ??
              DatabaseConstants.emptyWinRate,
      totalWinRateDefinition:
          (json['totalWinRateDefinition'] as num?)?.toDouble() ??
              DatabaseConstants.emptyWinRate,
      lastUpdated: json['lastUpdated'] as int,
    );

Map<String, dynamic> _$WordListToJson(WordList instance) => <String, dynamic>{
      'name': instance.name,
      'totalWinRateWriting': instance.totalWinRateWriting,
      'totalWinRateReading': instance.totalWinRateReading,
      'totalWinRateRecognition': instance.totalWinRateRecognition,
      'totalWinRateListening': instance.totalWinRateListening,
      'totalWinRateSpeaking': instance.totalWinRateSpeaking,
      'totalWinRateDefinition': instance.totalWinRateDefinition,
      'lastUpdated': instance.lastUpdated,
    };
