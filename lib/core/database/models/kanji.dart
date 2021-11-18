import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';

part 'kanji.g.dart';

@JsonSerializable()
class Kanji {
  @JsonKey(name: KanjiTableFields.kanjiField)
  final String kanji;
  @JsonKey(name: KanjiTableFields.listNameField)
  final String listName;
  @JsonKey(name: KanjiTableFields.meaningField)
  final String meaning;
  @JsonKey(name: KanjiTableFields.pronunciationField)
  final String pronunciation;
  @JsonKey(name: KanjiTableFields.winRateWritingField)
  final double winRateWriting;
  @JsonKey(name: KanjiTableFields.winRateReadingField)
  final double winRateReading;
  @JsonKey(name: KanjiTableFields.winRateRecognitionField)
  final double winRateRecognition;
  @JsonKey(name: KanjiTableFields.dateAddedField)
  final int dateAdded;

  const Kanji({required this.kanji, required this.listName, required this.meaning,
    required this.pronunciation, this.winRateReading = DatabaseConstants.emptyWinRate,
    this.winRateRecognition = DatabaseConstants.emptyWinRate,
    this.winRateWriting = DatabaseConstants.emptyWinRate, this.dateAdded = 0
  });

  /// Empty [Kanji]
  static const Kanji empty = Kanji(kanji: "", listName: "", meaning: "", pronunciation: "", dateAdded: 0);

  factory Kanji.fromJson(Map<String, dynamic> json) => _$KanjiFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiToJson(this);
}