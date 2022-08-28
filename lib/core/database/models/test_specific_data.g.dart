// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_specific_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestSpecificData _$TestSpecificDataFromJson(Map<String, dynamic> json) =>
    TestSpecificData(
      id: json['id'] as int,
      totalWinRateWriting: (json['totalWinRateWriting'] as num).toDouble(),
      totalWinRateReading: (json['totalWinRateReading'] as num).toDouble(),
      totalWinRateRecognition:
          (json['totalWinRateRecognition'] as num).toDouble(),
      totalWinRateListening: (json['totalWinRateListening'] as num).toDouble(),
      totalWinRateSpeaking: (json['totalWinRateSpeaking'] as num).toDouble(),
    );

Map<String, dynamic> _$TestSpecificDataToJson(TestSpecificData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalWinRateWriting': instance.totalWinRateWriting,
      'totalWinRateReading': instance.totalWinRateReading,
      'totalWinRateRecognition': instance.totalWinRateRecognition,
      'totalWinRateListening': instance.totalWinRateListening,
      'totalWinRateSpeaking': instance.totalWinRateSpeaking,
    };
