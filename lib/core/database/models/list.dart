import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'list.g.dart';

@JsonSerializable()
class KanjiList {
  final String name;
  double totalWinRateWriting;
  double totalWinRateReading;
  double totalWinRateRecognition;
  double totalWinRateListening;
  double totalWinRateSpeaking;
  final int lastUpdated;

  KanjiList(
      {required this.name,
      this.totalWinRateWriting = DatabaseConstants.emptyWinRate,
      this.totalWinRateReading = DatabaseConstants.emptyWinRate,
      this.totalWinRateRecognition = DatabaseConstants.emptyWinRate,
      this.totalWinRateListening = DatabaseConstants.emptyWinRate,
      this.totalWinRateSpeaking = DatabaseConstants.emptyWinRate,
      required this.lastUpdated});

  /// Empty [KanjiList]
  static final KanjiList empty = KanjiList(name: "", lastUpdated: 0);

  factory KanjiList.fromJson(Map<String, dynamic> json) =>
      _$KanjiListFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiListToJson(this);

  KanjiList copyWithUpdatedDate({int? lastUpdated}) => KanjiList(
      name: name,
      totalWinRateWriting: totalWinRateWriting,
      totalWinRateReading: totalWinRateReading,
      totalWinRateRecognition: totalWinRateRecognition,
      totalWinRateListening: totalWinRateListening,
      totalWinRateSpeaking: totalWinRateSpeaking,
      lastUpdated: lastUpdated ?? this.lastUpdated);

  KanjiList copyWithReset() => KanjiList(
      name: name,
      totalWinRateWriting: DatabaseConstants.emptyWinRate,
      totalWinRateReading: DatabaseConstants.emptyWinRate,
      totalWinRateRecognition: DatabaseConstants.emptyWinRate,
      totalWinRateListening: DatabaseConstants.emptyWinRate,
      totalWinRateSpeaking: DatabaseConstants.emptyWinRate,
      lastUpdated: Utils.getCurrentMilliseconds());
}
