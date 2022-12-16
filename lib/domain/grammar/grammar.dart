import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'grammar.g.dart';

@JsonSerializable()
class Grammar {
  final String name;
  final String listName;
  final String definition;
  final String example;
  final double winRateDefinition;
  final double winRateRecognition;
  final int dateAdded;
  final int dateLastShown;
  final int dateLastShownDefinition;
  final int dateLastShownRecognition;
  final int repetitionsDefinition;
  final double previousEaseFactorDefinition;
  final int previousIntervalDefinition;
  final int previousIntervalAsDateDefinition;
  final int repetitionsRecognition;
  final double previousEaseFactorRecognition;
  final int previousIntervalRecognition;
  final int previousIntervalAsDateRecognition;

  const Grammar({
    required this.name,
    required this.listName,
    required this.definition,
    required this.example,
    this.winRateRecognition = DatabaseConstants.emptyWinRate,
    this.winRateDefinition = DatabaseConstants.emptyWinRate,
    this.dateAdded = 0,
    this.dateLastShown = 0,
    this.dateLastShownDefinition = 0,
    this.dateLastShownRecognition = 0,
    this.repetitionsDefinition = 0,
    this.previousEaseFactorDefinition = 2.5,
    this.previousIntervalDefinition = 0,
    this.previousIntervalAsDateDefinition = 0,
    this.repetitionsRecognition = 0,
    this.previousEaseFactorRecognition = 2.5,
    this.previousIntervalRecognition = 0,
    this.previousIntervalAsDateRecognition = 0,
  });

  /// Empty [Grammar]
  static const Grammar empty =
      Grammar(name: "", listName: "", definition: "", example: "");

  factory Grammar.fromJson(Map<String, dynamic> json) =>
      _$GrammarFromJson(json);
  Map<String, dynamic> toJson() => _$GrammarToJson(this);

  Grammar copyWithUpdatedDate({int? dateAdded, int? dateLastShown}) => Grammar(
        name: name,
        listName: listName,
        definition: definition,
        example: example,
        winRateDefinition: winRateDefinition,
        winRateRecognition: winRateRecognition,
        dateLastShownRecognition: dateLastShownRecognition,
        dateLastShownDefinition: dateLastShownDefinition,
        dateAdded: dateAdded ?? this.dateAdded,
        dateLastShown: dateLastShown ?? this.dateLastShown,
        repetitionsDefinition: repetitionsDefinition,
        previousEaseFactorDefinition: previousEaseFactorDefinition,
        previousIntervalDefinition: previousIntervalDefinition,
        previousIntervalAsDateDefinition: previousIntervalAsDateDefinition,
        repetitionsRecognition: repetitionsRecognition,
        previousEaseFactorRecognition: previousEaseFactorRecognition,
        previousIntervalRecognition: previousIntervalRecognition,
        previousIntervalAsDateRecognition: previousIntervalAsDateRecognition,
      );

  Grammar copyWithReset() => Grammar(
        name: name,
        listName: listName,
        definition: definition,
        example: example,
        winRateDefinition: DatabaseConstants.emptyWinRate,
        winRateRecognition: DatabaseConstants.emptyWinRate,
        dateLastShownRecognition: Utils.getCurrentMilliseconds(),
        dateLastShownDefinition: Utils.getCurrentMilliseconds(),
        dateAdded: dateAdded,
        dateLastShown: Utils.getCurrentMilliseconds(),
        repetitionsDefinition: 0,
        previousEaseFactorDefinition: 2.5,
        previousIntervalDefinition: 0,
        previousIntervalAsDateDefinition: 0,
        repetitionsRecognition: 0,
        previousEaseFactorRecognition: 2.5,
        previousIntervalRecognition: 0,
        previousIntervalAsDateRecognition: 0,
      );
}
