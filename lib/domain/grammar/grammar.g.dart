// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grammar _$GrammarFromJson(Map<String, dynamic> json) => Grammar(
      name: json['name'] as String,
      listName: json['listName'] as String,
      definition: json['definition'] as String,
      example: json['example'] as String,
      winRateRecognition: (json['winRateRecognition'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      winRateDefinition: (json['winRateDefinition'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      dateAdded: json['dateAdded'] as int? ?? 0,
      dateLastShown: json['dateLastShown'] as int? ?? 0,
      dateLastShownDefinition: json['dateLastShownDefinition'] as int? ?? 0,
      dateLastShownRecognition: json['dateLastShownRecognition'] as int? ?? 0,
      repetitionsDefinition: json['repetitionsDefinition'] as int? ?? 0,
      previousEaseFactorDefinition:
          (json['previousEaseFactorDefinition'] as num?)?.toDouble() ?? 2.5,
      previousIntervalDefinition:
          json['previousIntervalDefinition'] as int? ?? 0,
      previousIntervalAsDateDefinition:
          json['previousIntervalAsDateDefinition'] as int? ?? 0,
      repetitionsRecognition: json['repetitionsRecognition'] as int? ?? 0,
      previousEaseFactorRecognition:
          (json['previousEaseFactorRecognition'] as num?)?.toDouble() ?? 2.5,
      previousIntervalRecognition:
          json['previousIntervalRecognition'] as int? ?? 0,
      previousIntervalAsDateRecognition:
          json['previousIntervalAsDateRecognition'] as int? ?? 0,
    );

Map<String, dynamic> _$GrammarToJson(Grammar instance) => <String, dynamic>{
      'name': instance.name,
      'listName': instance.listName,
      'definition': instance.definition,
      'example': instance.example,
      'winRateDefinition': instance.winRateDefinition,
      'winRateRecognition': instance.winRateRecognition,
      'dateAdded': instance.dateAdded,
      'dateLastShown': instance.dateLastShown,
      'dateLastShownDefinition': instance.dateLastShownDefinition,
      'dateLastShownRecognition': instance.dateLastShownRecognition,
      'repetitionsDefinition': instance.repetitionsDefinition,
      'previousEaseFactorDefinition': instance.previousEaseFactorDefinition,
      'previousIntervalDefinition': instance.previousIntervalDefinition,
      'previousIntervalAsDateDefinition':
          instance.previousIntervalAsDateDefinition,
      'repetitionsRecognition': instance.repetitionsRecognition,
      'previousEaseFactorRecognition': instance.previousEaseFactorRecognition,
      'previousIntervalRecognition': instance.previousIntervalRecognition,
      'previousIntervalAsDateRecognition':
          instance.previousIntervalAsDateRecognition,
    };
