// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackUp _$BackUpFromJson(Map<String, dynamic> json) => BackUp(
      lists: (json['lists'] as List<dynamic>)
          .map((e) => KanjiList.fromJson(e as Map<String, dynamic>))
          .toList(),
      kanji: (json['kanji'] as List<dynamic>)
          .map((e) => Kanji.fromJson(e as Map<String, dynamic>))
          .toList(),
      testData: TestData.fromJson(json['testData'] as Map<String, dynamic>),
      lastUpdated: json['lastUpdated'] as int,
    );

Map<String, dynamic> _$BackUpToJson(BackUp instance) => <String, dynamic>{
      'lists': instance.lists,
      'kanji': instance.kanji,
      'testData': instance.testData,
      'lastUpdated': instance.lastUpdated,
    };
