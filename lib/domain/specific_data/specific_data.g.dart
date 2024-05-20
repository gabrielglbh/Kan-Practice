// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specific_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificData _$SpecificDataFromJson(Map<String, dynamic> json) => SpecificData(
      id: (json['id'] as num).toInt(),
      totalWritingCount: (json['totalWritingCount'] as num).toInt(),
      totalReadingCount: (json['totalReadingCount'] as num).toInt(),
      totalRecognitionCount: (json['totalRecognitionCount'] as num).toInt(),
      totalListeningCount: (json['totalListeningCount'] as num).toInt(),
      totalSpeakingCount: (json['totalSpeakingCount'] as num).toInt(),
      totalDefinitionCount: (json['totalDefinitionCount'] as num).toInt(),
      totalGrammarPointCount: (json['totalGrammarPointCount'] as num).toInt(),
      totalWinRateWriting: (json['totalWinRateWriting'] as num).toDouble(),
      totalWinRateReading: (json['totalWinRateReading'] as num).toDouble(),
      totalWinRateRecognition:
          (json['totalWinRateRecognition'] as num).toDouble(),
      totalWinRateListening: (json['totalWinRateListening'] as num).toDouble(),
      totalWinRateSpeaking: (json['totalWinRateSpeaking'] as num).toDouble(),
      totalWinRateDefinition:
          (json['totalWinRateDefinition'] as num).toDouble(),
      totalWinRateGrammarPoint:
          (json['totalWinRateGrammarPoint'] as num).toDouble(),
    );

Map<String, dynamic> _$SpecificDataToJson(SpecificData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalWritingCount': instance.totalWritingCount,
      'totalReadingCount': instance.totalReadingCount,
      'totalRecognitionCount': instance.totalRecognitionCount,
      'totalListeningCount': instance.totalListeningCount,
      'totalSpeakingCount': instance.totalSpeakingCount,
      'totalDefinitionCount': instance.totalDefinitionCount,
      'totalGrammarPointCount': instance.totalGrammarPointCount,
      'totalWinRateWriting': instance.totalWinRateWriting,
      'totalWinRateReading': instance.totalWinRateReading,
      'totalWinRateRecognition': instance.totalWinRateRecognition,
      'totalWinRateListening': instance.totalWinRateListening,
      'totalWinRateSpeaking': instance.totalWinRateSpeaking,
      'totalWinRateDefinition': instance.totalWinRateDefinition,
      'totalWinRateGrammarPoint': instance.totalWinRateGrammarPoint,
    };
