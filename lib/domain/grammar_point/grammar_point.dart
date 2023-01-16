import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'grammar_point.g.dart';

@JsonSerializable()
class GrammarPoint {
  final String name;
  final String listName;
  final String definition;
  final String example;
  final double winRateDefinition;
  final double winRateGrammarPoint;
  final int dateAdded;
  final int dateLastShown;
  final int dateLastShownDefinition;
  final int repetitionsDefinition;
  final double previousEaseFactorDefinition;
  final int previousIntervalDefinition;
  final int previousIntervalAsDateDefinition;
  final int dateLastShownGrammarPoint;
  final int repetitionsGrammarPoint;
  final double previousEaseFactorGrammarPoint;
  final int previousIntervalGrammarPoint;
  final int previousIntervalAsDateGrammarPoint;

  const GrammarPoint({
    required this.name,
    required this.listName,
    required this.definition,
    required this.example,
    this.winRateDefinition = DatabaseConstants.emptyWinRate,
    this.winRateGrammarPoint = DatabaseConstants.emptyWinRate,
    this.dateAdded = 0,
    this.dateLastShown = 0,
    this.dateLastShownDefinition = 0,
    this.repetitionsDefinition = 0,
    this.previousEaseFactorDefinition = 2.5,
    this.previousIntervalDefinition = 0,
    this.previousIntervalAsDateDefinition = 0,
    this.dateLastShownGrammarPoint = 0,
    this.repetitionsGrammarPoint = 0,
    this.previousEaseFactorGrammarPoint = 2.5,
    this.previousIntervalGrammarPoint = 0,
    this.previousIntervalAsDateGrammarPoint = 0,
  });

  /// Empty [GrammarPoint]
  static const GrammarPoint empty =
      GrammarPoint(name: "", listName: "", definition: "", example: "");

  factory GrammarPoint.fromJson(Map<String, dynamic> json) =>
      _$GrammarPointFromJson(json);
  Map<String, dynamic> toJson() => _$GrammarPointToJson(this);

  @override
  bool operator ==(other) {
    if (other is! GrammarPoint) return false;
    return name == other.name &&
        definition == other.definition &&
        example == other.example;
  }

  @override
  int get hashCode => (name + definition + example).hashCode;

  GrammarPoint copyWithUpdatedDate({int? dateAdded, int? dateLastShown}) =>
      GrammarPoint(
        name: name,
        listName: listName,
        definition: definition,
        example: example,
        winRateDefinition: winRateDefinition,
        winRateGrammarPoint: winRateGrammarPoint,
        dateLastShownDefinition: dateLastShownDefinition,
        dateLastShownGrammarPoint: dateLastShownGrammarPoint,
        dateAdded: dateAdded ?? this.dateAdded,
        dateLastShown: dateLastShown ?? this.dateLastShown,
        repetitionsDefinition: repetitionsDefinition,
        previousEaseFactorDefinition: previousEaseFactorDefinition,
        previousIntervalDefinition: previousIntervalDefinition,
        previousIntervalAsDateDefinition: previousIntervalAsDateDefinition,
        repetitionsGrammarPoint: repetitionsGrammarPoint,
        previousEaseFactorGrammarPoint: previousEaseFactorGrammarPoint,
        previousIntervalGrammarPoint: previousIntervalGrammarPoint,
        previousIntervalAsDateGrammarPoint: previousIntervalAsDateGrammarPoint,
      );

  GrammarPoint copyWithReset() => GrammarPoint(
        name: name,
        listName: listName,
        definition: definition,
        example: example,
        winRateDefinition: DatabaseConstants.emptyWinRate,
        winRateGrammarPoint: DatabaseConstants.emptyWinRate,
        dateLastShownDefinition: Utils.getCurrentMilliseconds(),
        dateLastShownGrammarPoint: Utils.getCurrentMilliseconds(),
        dateAdded: dateAdded,
        dateLastShown: Utils.getCurrentMilliseconds(),
        repetitionsDefinition: 0,
        previousEaseFactorDefinition: 2.5,
        previousIntervalDefinition: 0,
        previousIntervalAsDateDefinition: 0,
        repetitionsGrammarPoint: 0,
        previousEaseFactorGrammarPoint: 2.5,
        previousIntervalGrammarPoint: 0,
        previousIntervalAsDateGrammarPoint: 0,
      );
}
