// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alter_specific_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlterSpecificData _$AlterSpecificDataFromJson(Map<String, dynamic> json) =>
    AlterSpecificData(
      id: json['id'] as int,
      totalNumberTestCount: json['totalNumberTestCount'] as int,
      totalTranslationTestCount: json['totalTranslationTestCount'] as int,
      totalWinRateNumberTest:
          (json['totalWinRateNumberTest'] as num).toDouble(),
      totalWinRateTranslationTest:
          (json['totalWinRateTranslationTest'] as num).toDouble(),
    );

Map<String, dynamic> _$AlterSpecificDataToJson(AlterSpecificData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalNumberTestCount': instance.totalNumberTestCount,
      'totalTranslationTestCount': instance.totalTranslationTestCount,
      'totalWinRateNumberTest': instance.totalWinRateNumberTest,
      'totalWinRateTranslationTest': instance.totalWinRateTranslationTest,
    };
