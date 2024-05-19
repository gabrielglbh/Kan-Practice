// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackUp _$BackUpFromJson(Map<String, dynamic> json) => BackUp(
      lists: (json['lists'] as List<dynamic>)
          .map((e) => WordList.fromJson(e as Map<String, dynamic>))
          .toList(),
      words: (json['words'] as List<dynamic>)
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList(),
      testData: TestData.fromJson(json['testData'] as Map<String, dynamic>),
      testSpecData: (json['testSpecData'] as List<dynamic>)
          .map((e) => SpecificData.fromJson(e as Map<String, dynamic>))
          .toList(),
      folders: (json['folders'] as List<dynamic>)
          .map((e) => Folder.fromJson(e as Map<String, dynamic>))
          .toList(),
      relationFolderList: (json['relationFolderList'] as List<dynamic>)
          .map((e) => RelationFolderList.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: (json['lastUpdated'] as num).toInt(),
    );

Map<String, dynamic> _$BackUpToJson(BackUp instance) => <String, dynamic>{
      'lists': instance.lists,
      'words': instance.words,
      'testData': instance.testData,
      'testSpecData': instance.testSpecData,
      'folders': instance.folders,
      'relationFolderList': instance.relationFolderList,
      'lastUpdated': instance.lastUpdated,
    };
