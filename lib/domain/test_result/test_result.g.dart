// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      takenDate: json['takenDate'] as int,
      testScore: (json['score'] as num).toDouble(),
      lists: json['kanjiLists'] as String,
      wordsInTest: json['totalKanji'] as int,
      studyMode: json['studyMode'] as int?,
      grammarMode: json['grammarMode'] as int?,
      testMode: json['testMode'] as int? ?? -1,
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'takenDate': instance.takenDate,
      'score': instance.testScore,
      'totalKanji': instance.wordsInTest,
      'kanjiLists': instance.lists,
      'testMode': instance.testMode,
      'studyMode': instance.studyMode,
      'grammarMode': instance.grammarMode,
    };
