// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specific_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificData _$SpecificDataFromJson(Map<String, dynamic> json) => SpecificData(
      id: json['id'] as int,
      totalWritingCount: json['totalWritingCount'] as int,
      totalReadingCount: json['totalReadingCount'] as int,
      totalRecognitionCount: json['totalRecognitionCount'] as int,
      totalListeningCount: json['totalListeningCount'] as int,
      totalSpeakingCount: json['totalSpeakingCount'] as int,
      totalWinRateWriting: (json['totalWinRateWriting'] as num).toDouble(),
      totalWinRateReading: (json['totalWinRateReading'] as num).toDouble(),
      totalWinRateRecognition:
          (json['totalWinRateRecognition'] as num).toDouble(),
      totalWinRateListening: (json['totalWinRateListening'] as num).toDouble(),
      totalWinRateSpeaking: (json['totalWinRateSpeaking'] as num).toDouble(),
    );

Map<String, dynamic> _$SpecificDataToJson(SpecificData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalWritingCount': instance.totalWritingCount,
      'totalReadingCount': instance.totalReadingCount,
      'totalRecognitionCount': instance.totalRecognitionCount,
      'totalListeningCount': instance.totalListeningCount,
      'totalSpeakingCount': instance.totalSpeakingCount,
      'totalWinRateWriting': instance.totalWinRateWriting,
      'totalWinRateReading': instance.totalWinRateReading,
      'totalWinRateRecognition': instance.totalWinRateRecognition,
      'totalWinRateListening': instance.totalWinRateListening,
      'totalWinRateSpeaking': instance.totalWinRateSpeaking,
    };
