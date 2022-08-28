// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestData _$TestDataFromJson(Map<String, dynamic> json) => TestData(
      statsId: json['statsId'] as String? ?? TestDataTableFields.statsMainId,
      totalTests: json['totalTests'] as int,
      totalTestAccuracy: (json['totalTestAccuracy'] as num).toDouble(),
      testTotalCountWriting: json['testTotalCountWriting'] as int,
      testTotalCountReading: json['testTotalCountReading'] as int,
      testTotalCountRecognition: json['testTotalCountRecognition'] as int,
      testTotalCountListening: json['testTotalCountListening'] as int,
      testTotalCountSpeaking: json['testTotalCountSpeaking'] as int,
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
      selectionTests: json['selectionTests'] as int,
      selectionTestData: TestSpecificData.fromJson(
          json['selectionTestData'] as Map<String, dynamic>),
      blitzTests: json['blitzTests'] as int,
      blitzTestData: TestSpecificData.fromJson(
          json['blitzTestData'] as Map<String, dynamic>),
      remembranceTests: json['remembranceTests'] as int,
      remembranceTestData: TestSpecificData.fromJson(
          json['remembranceTestData'] as Map<String, dynamic>),
      numberTests: json['numberTests'] as int,
      numberTestData: TestSpecificData.fromJson(
          json['numberTestData'] as Map<String, dynamic>),
      lessPctTests: json['lessPctTests'] as int,
      lessPctTestData: TestSpecificData.fromJson(
          json['lessPctTestData'] as Map<String, dynamic>),
      categoryTests: json['categoryTests'] as int,
      categoryTestData: TestSpecificData.fromJson(
          json['categoryTestData'] as Map<String, dynamic>),
      folderTests: json['folderTests'] as int,
      folderTestData: TestSpecificData.fromJson(
          json['folderTestData'] as Map<String, dynamic>),
      dailyTests: json['dailyTests'] as int,
      dailyTestData: TestSpecificData.fromJson(
          json['dailyTestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestDataToJson(TestData instance) => <String, dynamic>{
      'statsId': instance.statsId,
      'totalTests': instance.totalTests,
      'totalTestAccuracy': instance.totalTestAccuracy,
      'testTotalCountWriting': instance.testTotalCountWriting,
      'testTotalCountReading': instance.testTotalCountReading,
      'testTotalCountRecognition': instance.testTotalCountRecognition,
      'testTotalCountListening': instance.testTotalCountListening,
      'testTotalCountSpeaking': instance.testTotalCountSpeaking,
      'testTotalWinRateWriting': instance.testTotalWinRateWriting,
      'testTotalWinRateReading': instance.testTotalWinRateReading,
      'testTotalWinRateRecognition': instance.testTotalWinRateRecognition,
      'testTotalWinRateListening': instance.testTotalWinRateListening,
      'testTotalWinRateSpeaking': instance.testTotalWinRateSpeaking,
      'selectionTests': instance.selectionTests,
      'selectionTestData': instance.selectionTestData,
      'blitzTests': instance.blitzTests,
      'blitzTestData': instance.blitzTestData,
      'remembranceTests': instance.remembranceTests,
      'remembranceTestData': instance.remembranceTestData,
      'numberTests': instance.numberTests,
      'numberTestData': instance.numberTestData,
      'lessPctTests': instance.lessPctTests,
      'lessPctTestData': instance.lessPctTestData,
      'categoryTests': instance.categoryTests,
      'categoryTestData': instance.categoryTestData,
      'folderTests': instance.folderTests,
      'folderTestData': instance.folderTestData,
      'dailyTests': instance.dailyTests,
      'dailyTestData': instance.dailyTestData,
    };
