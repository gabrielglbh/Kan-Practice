// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test(
    takenDate: json['takenDate'] as int,
    testScore: (json['score'] as num).toDouble(),
    kanjiLists: json['kanjiLists'] as String,
    kanjiInTest: json['totalKanji'] as int,
    studyMode: json['studyMode'] as String,
  );
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'takenDate': instance.takenDate,
      'score': instance.testScore,
      'totalKanji': instance.kanjiInTest,
      'kanjiLists': instance.kanjiLists,
      'studyMode': instance.studyMode,
    };
