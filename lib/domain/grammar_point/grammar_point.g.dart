// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrammarPoint _$GrammarPointFromJson(Map<String, dynamic> json) => GrammarPoint(
      name: json['name'] as String,
      listName: json['listName'] as String,
      definition: json['definition'] as String,
      example: json['example'] as String,
      winRateDefinition: (json['winRateDefinition'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      dateAdded: json['dateAdded'] as int? ?? 0,
      dateLastShown: json['dateLastShown'] as int? ?? 0,
      dateLastShownDefinition: json['dateLastShownDefinition'] as int? ?? 0,
      repetitionsDefinition: json['repetitionsDefinition'] as int? ?? 0,
      previousEaseFactorDefinition:
          (json['previousEaseFactorDefinition'] as num?)?.toDouble() ?? 2.5,
      previousIntervalDefinition:
          json['previousIntervalDefinition'] as int? ?? 0,
      previousIntervalAsDateDefinition:
          json['previousIntervalAsDateDefinition'] as int? ?? 0,
    );

Map<String, dynamic> _$GrammarPointToJson(GrammarPoint instance) =>
    <String, dynamic>{
      'name': instance.name,
      'listName': instance.listName,
      'definition': instance.definition,
      'example': instance.example,
      'winRateDefinition': instance.winRateDefinition,
      'dateAdded': instance.dateAdded,
      'dateLastShown': instance.dateLastShown,
      'dateLastShownDefinition': instance.dateLastShownDefinition,
      'repetitionsDefinition': instance.repetitionsDefinition,
      'previousEaseFactorDefinition': instance.previousEaseFactorDefinition,
      'previousIntervalDefinition': instance.previousIntervalDefinition,
      'previousIntervalAsDateDefinition':
          instance.previousIntervalAsDateDefinition,
    };
