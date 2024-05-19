// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alter_specific_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlterSpecificData _$AlterSpecificDataFromJson(Map<String, dynamic> json) =>
    AlterSpecificData(
      id: (json['id'] as num).toInt(),
      totalNumberTestCount: (json['totalNumberTestCount'] as num).toInt(),
      totalWinRateNumberTest:
          (json['totalWinRateNumberTest'] as num).toDouble(),
    );

Map<String, dynamic> _$AlterSpecificDataToJson(AlterSpecificData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalNumberTestCount': instance.totalNumberTestCount,
      'totalWinRateNumberTest': instance.totalWinRateNumberTest,
    };
