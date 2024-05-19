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
      winRateGrammarPoint: (json['winRateGrammarPoint'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      dateAdded: (json['dateAdded'] as num?)?.toInt() ?? 0,
      dateLastShown: (json['dateLastShown'] as num?)?.toInt() ?? 0,
      dateLastShownDefinition:
          (json['dateLastShownDefinition'] as num?)?.toInt() ?? 0,
      repetitionsDefinition:
          (json['repetitionsDefinition'] as num?)?.toInt() ?? 0,
      previousEaseFactorDefinition:
          (json['previousEaseFactorDefinition'] as num?)?.toDouble() ?? 2.5,
      previousIntervalDefinition:
          (json['previousIntervalDefinition'] as num?)?.toInt() ?? 0,
      previousIntervalAsDateDefinition:
          (json['previousIntervalAsDateDefinition'] as num?)?.toInt() ?? 0,
      dateLastShownGrammarPoint:
          (json['dateLastShownGrammarPoint'] as num?)?.toInt() ?? 0,
      repetitionsGrammarPoint:
          (json['repetitionsGrammarPoint'] as num?)?.toInt() ?? 0,
      previousEaseFactorGrammarPoint:
          (json['previousEaseFactorGrammarPoint'] as num?)?.toDouble() ?? 2.5,
      previousIntervalGrammarPoint:
          (json['previousIntervalGrammarPoint'] as num?)?.toInt() ?? 0,
      previousIntervalAsDateGrammarPoint:
          (json['previousIntervalAsDateGrammarPoint'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GrammarPointToJson(GrammarPoint instance) =>
    <String, dynamic>{
      'name': instance.name,
      'listName': instance.listName,
      'definition': instance.definition,
      'example': instance.example,
      'winRateDefinition': instance.winRateDefinition,
      'winRateGrammarPoint': instance.winRateGrammarPoint,
      'dateAdded': instance.dateAdded,
      'dateLastShown': instance.dateLastShown,
      'dateLastShownDefinition': instance.dateLastShownDefinition,
      'repetitionsDefinition': instance.repetitionsDefinition,
      'previousEaseFactorDefinition': instance.previousEaseFactorDefinition,
      'previousIntervalDefinition': instance.previousIntervalDefinition,
      'previousIntervalAsDateDefinition':
          instance.previousIntervalAsDateDefinition,
      'dateLastShownGrammarPoint': instance.dateLastShownGrammarPoint,
      'repetitionsGrammarPoint': instance.repetitionsGrammarPoint,
      'previousEaseFactorGrammarPoint': instance.previousEaseFactorGrammarPoint,
      'previousIntervalGrammarPoint': instance.previousIntervalGrammarPoint,
      'previousIntervalAsDateGrammarPoint':
          instance.previousIntervalAsDateGrammarPoint,
    };
