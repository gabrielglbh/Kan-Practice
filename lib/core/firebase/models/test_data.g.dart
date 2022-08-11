// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestData _$TestDataFromJson(Map<String, dynamic> json) => TestData(
      totalTests: json['totalTests'] as int,
      totalTestAccuracy: (json['totalTestAccuracy'] as num).toDouble(),
      testTotalCountWriting: json['testTotalCountWriting'] as int,
      testTotalCountReading: json['testTotalCountReading'] as int,
      testTotalCountRecognition: json['testTotalCountRecognition'] as int,
      testTotalCountListening: json['testTotalCountListening'] as int,
      testTotalWinRateWriting:
          (json['testTotalWinRateWriting'] as num).toDouble(),
      testTotalWinRateReading:
          (json['testTotalWinRateReading'] as num).toDouble(),
      testTotalWinRateRecognition:
          (json['testTotalWinRateRecognition'] as num).toDouble(),
      testTotalWinRateListening:
          (json['testTotalWinRateListening'] as num).toDouble(),
      selectionTests: json['selectionTests'] as int,
      blitzTests: json['blitzTests'] as int,
      remembranceTests: json['remembranceTests'] as int,
      numberTests: json['numberTests'] as int,
      lessPctTests: json['lessPctTests'] as int,
      categoryTests: json['categoryTests'] as int,
      folderTests: json['folderTests'] as int,
      dailyTests: json['dailyTests'] as int,
    );

Map<String, dynamic> _$TestDataToJson(TestData instance) => <String, dynamic>{
      'totalTests': instance.totalTests,
      'totalTestAccuracy': instance.totalTestAccuracy,
      'testTotalCountWriting': instance.testTotalCountWriting,
      'testTotalCountReading': instance.testTotalCountReading,
      'testTotalCountRecognition': instance.testTotalCountRecognition,
      'testTotalCountListening': instance.testTotalCountListening,
      'testTotalWinRateWriting': instance.testTotalWinRateWriting,
      'testTotalWinRateReading': instance.testTotalWinRateReading,
      'testTotalWinRateRecognition': instance.testTotalWinRateRecognition,
      'testTotalWinRateListening': instance.testTotalWinRateListening,
      'selectionTests': instance.selectionTests,
      'blitzTests': instance.blitzTests,
      'remembranceTests': instance.remembranceTests,
      'numberTests': instance.numberTests,
      'lessPctTests': instance.lessPctTests,
      'categoryTests': instance.categoryTests,
      'folderTests': instance.folderTests,
      'dailyTests': instance.dailyTests,
    };
