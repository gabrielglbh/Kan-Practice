// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      takenDate: (json['takenDate'] as num).toInt(),
      testScore: (json['score'] as num).toDouble(),
      lists: json['kanjiLists'] as String,
      wordsInTest: (json['totalKanji'] as num).toInt(),
      studyMode: (json['studyMode'] as num?)?.toInt(),
      grammarMode: (json['grammarMode'] as num?)?.toInt(),
      testMode: (json['testMode'] as num?)?.toInt() ?? -1,
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
