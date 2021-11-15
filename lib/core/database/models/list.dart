import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';

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
  @JsonKey(name: KanListTableFields.lastUpdatedField)
  final int lastUpdated;

  KanjiList({required this.name, this.totalWinRateWriting = -1, this.totalWinRateReading = -1,
    this.totalWinRateRecognition = -1, required this.lastUpdated
  });

  /// Empty [KanjiList]
  static final KanjiList empty = KanjiList(name: "", lastUpdated: 0);

  factory KanjiList.fromJson(Map<String, dynamic> json) => _$KanjiListFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiListToJson(this);
}