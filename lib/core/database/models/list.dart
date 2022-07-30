import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/ui/general_utils.dart';

part 'list.g.dart';

@JsonSerializable()
class KanjiList {
  final String name;
  String? folder;
  double totalWinRateWriting;
  double totalWinRateReading;
  double totalWinRateRecognition;
  double totalWinRateListening;
  final int lastUpdated;

  KanjiList(
      {required this.name,
      this.folder,
      this.totalWinRateWriting = DatabaseConstants.emptyWinRate,
      this.totalWinRateReading = DatabaseConstants.emptyWinRate,
      this.totalWinRateRecognition = DatabaseConstants.emptyWinRate,
      this.totalWinRateListening = DatabaseConstants.emptyWinRate,
      required this.lastUpdated});

  /// Empty [KanjiList]
  static final KanjiList empty = KanjiList(name: "", lastUpdated: 0);

  factory KanjiList.fromJson(Map<String, dynamic> json) =>
      _$KanjiListFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiListToJson(this);

  KanjiList copyWithUpdatedDate({int? lastUpdated}) => KanjiList(
      name: name,
      folder: folder,
      totalWinRateWriting: totalWinRateWriting,
      totalWinRateReading: totalWinRateReading,
      totalWinRateRecognition: totalWinRateRecognition,
      totalWinRateListening: totalWinRateListening,
      lastUpdated: lastUpdated ?? this.lastUpdated);

  KanjiList copyWithReset() => KanjiList(
      name: name,
      folder: folder,
      totalWinRateWriting: DatabaseConstants.emptyWinRate,
      totalWinRateReading: DatabaseConstants.emptyWinRate,
      totalWinRateRecognition: DatabaseConstants.emptyWinRate,
      totalWinRateListening: DatabaseConstants.emptyWinRate,
      lastUpdated: GeneralUtils.getCurrentMilliseconds());
}
