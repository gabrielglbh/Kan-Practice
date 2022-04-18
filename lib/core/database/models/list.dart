import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';

part 'list.g.dart';

@JsonSerializable()
class KanjiList {
  @JsonKey(name: KanListTableFields.nameField)
  final String name;
  @JsonKey(name: KanListTableFields.totalWinRateWritingField)
  double totalWinRateWriting;
  @JsonKey(name: KanListTableFields.totalWinRateReadingField)
  double totalWinRateReading;
  @JsonKey(name: KanListTableFields.totalWinRateRecognitionField)
  double totalWinRateRecognition;
  @JsonKey(name: KanListTableFields.totalWinRateListeningField)
  double totalWinRateListening;
  @JsonKey(name: KanListTableFields.lastUpdatedField)
  final int lastUpdated;

  KanjiList({required this.name, this.totalWinRateWriting =DatabaseConstants.emptyWinRate,
    this.totalWinRateReading = DatabaseConstants.emptyWinRate,
    this.totalWinRateRecognition = DatabaseConstants.emptyWinRate,
    this.totalWinRateListening = DatabaseConstants.emptyWinRate, required this.lastUpdated
  });

  /// Empty [KanjiList]
  static final KanjiList empty = KanjiList(name: "", lastUpdated: 0);

  factory KanjiList.fromJson(Map<String, dynamic> json) => _$KanjiListFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiListToJson(this);

  KanjiList copyWithUpdatedDate({int? lastUpdated}) => KanjiList(
    name: this.name,
    totalWinRateWriting: this.totalWinRateWriting,
    totalWinRateReading: this.totalWinRateReading,
    totalWinRateRecognition: this.totalWinRateRecognition,
    totalWinRateListening: this.totalWinRateListening,
    lastUpdated: lastUpdated ?? this.lastUpdated
  );

  KanjiList copyWithReset() => KanjiList(
      name: this.name,
      totalWinRateWriting: DatabaseConstants.emptyWinRate,
      totalWinRateReading: DatabaseConstants.emptyWinRate,
      totalWinRateRecognition: DatabaseConstants.emptyWinRate,
      totalWinRateListening: DatabaseConstants.emptyWinRate,
      lastUpdated: GeneralUtils.getCurrentMilliseconds()
  );
}