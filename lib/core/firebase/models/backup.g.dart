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
      test: (json['test'] as List<dynamic>)
          .map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] as int,
    );

Map<String, dynamic> _$BackUpToJson(BackUp instance) => <String, dynamic>{
      'lists': instance.lists,
      'kanji': instance.kanji,
      'test': instance.test,
      'lastUpdated': instance.lastUpdated,
    };
