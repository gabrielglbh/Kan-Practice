import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'list.g.dart';

@JsonSerializable()
class WordList {
  final String name;
  double totalWinRateWriting;
  double totalWinRateReading;
  double totalWinRateRecognition;
  double totalWinRateListening;
  double totalWinRateSpeaking;
  double totalWinRateDefinition;
  final int lastUpdated;

  WordList(
      {required this.name,
      this.totalWinRateWriting = DatabaseConstants.emptyWinRate,
      this.totalWinRateReading = DatabaseConstants.emptyWinRate,
      this.totalWinRateRecognition = DatabaseConstants.emptyWinRate,
      this.totalWinRateListening = DatabaseConstants.emptyWinRate,
      this.totalWinRateSpeaking = DatabaseConstants.emptyWinRate,
      this.totalWinRateDefinition = DatabaseConstants.emptyWinRate,
      required this.lastUpdated});

  /// Empty [WordList]
  static final WordList empty = WordList(name: "", lastUpdated: 0);

  factory WordList.fromJson(Map<String, dynamic> json) =>
      _$WordListFromJson(json);
  Map<String, dynamic> toJson() => _$WordListToJson(this);

  WordList copyWithUpdatedDate({int? lastUpdated}) => WordList(
      name: name,
      totalWinRateWriting: totalWinRateWriting,
      totalWinRateReading: totalWinRateReading,
      totalWinRateRecognition: totalWinRateRecognition,
      totalWinRateListening: totalWinRateListening,
      totalWinRateSpeaking: totalWinRateSpeaking,
      totalWinRateDefinition: totalWinRateDefinition,
      lastUpdated: lastUpdated ?? this.lastUpdated);

  WordList copyWithReset() => WordList(
      name: name,
      totalWinRateWriting: DatabaseConstants.emptyWinRate,
      totalWinRateReading: DatabaseConstants.emptyWinRate,
      totalWinRateRecognition: DatabaseConstants.emptyWinRate,
      totalWinRateListening: DatabaseConstants.emptyWinRate,
      totalWinRateSpeaking: DatabaseConstants.emptyWinRate,
      totalWinRateDefinition: DatabaseConstants.emptyWinRate,
      lastUpdated: Utils.getCurrentMilliseconds());
}
