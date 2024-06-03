// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestData _$TestDataFromJson(Map<String, dynamic> json) => TestData(
      statsId: json['statsId'] as String? ?? TestDataTableFields.statsMainId,
      totalTests: (json['totalTests'] as num).toInt(),
      testTotalCountWriting: (json['testTotalCountWriting'] as num).toInt(),
      testTotalCountReading: (json['testTotalCountReading'] as num).toInt(),
      testTotalCountRecognition:
          (json['testTotalCountRecognition'] as num).toInt(),
      testTotalCountListening: (json['testTotalCountListening'] as num).toInt(),
      testTotalCountSpeaking: (json['testTotalCountSpeaking'] as num).toInt(),
      testTotalCountDefinition:
          (json['testTotalCountDefinition'] as num).toInt(),
      testTotalCountGrammarPoint:
          (json['testTotalCountGrammarPoint'] as num).toInt(),
      testTotalWinRateWriting:
          (json['testTotalWinRateWriting'] as num).toDouble(),
      testTotalWinRateReading:
          (json['testTotalWinRateReading'] as num).toDouble(),
      testTotalWinRateRecognition:
          (json['testTotalWinRateRecognition'] as num).toDouble(),
      testTotalWinRateListening:
          (json['testTotalWinRateListening'] as num).toDouble(),
      testTotalWinRateSpeaking:
          (json['testTotalWinRateSpeaking'] as num).toDouble(),
      testTotalWinRateDefinition:
          (json['testTotalWinRateDefinition'] as num).toDouble(),
      testTotalWinRateGrammarPoint:
          (json['testTotalWinRateGrammarPoint'] as num).toDouble(),
      testTotalSecondsPerWordWriting:
          (json['testTotalSecondsPerWordWriting'] as num).toDouble(),
      testTotalSecondsPerWordReading:
          (json['testTotalSecondsPerWordReading'] as num).toDouble(),
      testTotalSecondsPerWordRecognition:
          (json['testTotalSecondsPerWordRecognition'] as num).toDouble(),
      testTotalSecondsPerWordListening:
          (json['testTotalSecondsPerWordListening'] as num).toDouble(),
      testTotalSecondsPerWordSpeaking:
          (json['testTotalSecondsPerWordSpeaking'] as num).toDouble(),
      testTotalSecondsPerPointDefinition:
          (json['testTotalSecondsPerPointDefinition'] as num).toDouble(),
      testTotalSecondsPerPointGrammarPoint:
          (json['testTotalSecondsPerPointGrammarPoint'] as num).toDouble(),
      selectionTests: (json['selectionTests'] as num).toInt(),
      blitzTests: (json['blitzTests'] as num).toInt(),
      remembranceTests: (json['remembranceTests'] as num).toInt(),
      numberTests: (json['numberTests'] as num).toInt(),
      lessPctTests: (json['lessPctTests'] as num).toInt(),
      categoryTests: (json['categoryTests'] as num).toInt(),
      folderTests: (json['folderTests'] as num).toInt(),
      dailyTests: (json['dailyTests'] as num).toInt(),
    );

Map<String, dynamic> _$TestDataToJson(TestData instance) => <String, dynamic>{
      'statsId': instance.statsId,
      'totalTests': instance.totalTests,
      'testTotalCountWriting': instance.testTotalCountWriting,
      'testTotalCountReading': instance.testTotalCountReading,
      'testTotalCountRecognition': instance.testTotalCountRecognition,
      'testTotalCountListening': instance.testTotalCountListening,
      'testTotalCountSpeaking': instance.testTotalCountSpeaking,
      'testTotalCountDefinition': instance.testTotalCountDefinition,
      'testTotalCountGrammarPoint': instance.testTotalCountGrammarPoint,
      'testTotalWinRateWriting': instance.testTotalWinRateWriting,
      'testTotalWinRateReading': instance.testTotalWinRateReading,
      'testTotalWinRateRecognition': instance.testTotalWinRateRecognition,
      'testTotalWinRateListening': instance.testTotalWinRateListening,
      'testTotalWinRateSpeaking': instance.testTotalWinRateSpeaking,
      'testTotalWinRateDefinition': instance.testTotalWinRateDefinition,
      'testTotalWinRateGrammarPoint': instance.testTotalWinRateGrammarPoint,
      'testTotalSecondsPerWordWriting': instance.testTotalSecondsPerWordWriting,
      'testTotalSecondsPerWordReading': instance.testTotalSecondsPerWordReading,
      'testTotalSecondsPerWordRecognition':
          instance.testTotalSecondsPerWordRecognition,
      'testTotalSecondsPerWordListening':
          instance.testTotalSecondsPerWordListening,
      'testTotalSecondsPerWordSpeaking':
          instance.testTotalSecondsPerWordSpeaking,
      'testTotalSecondsPerPointDefinition':
          instance.testTotalSecondsPerPointDefinition,
      'testTotalSecondsPerPointGrammarPoint':
          instance.testTotalSecondsPerPointGrammarPoint,
      'selectionTests': instance.selectionTests,
      'blitzTests': instance.blitzTests,
      'remembranceTests': instance.remembranceTests,
      'numberTests': instance.numberTests,
      'lessPctTests': instance.lessPctTests,
      'categoryTests': instance.categoryTests,
      'folderTests': instance.folderTests,
      'dailyTests': instance.dailyTests,
    };
