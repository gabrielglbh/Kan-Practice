import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';

part 'kanji.g.dart';

@JsonSerializable()
class Kanji {
  @JsonKey(name: kanjiField)
  final String kanji;
  @JsonKey(name: listNameField)
  final String listName;
  @JsonKey(name: meaningField)
  final String meaning;
  @JsonKey(name: pronunciationField)
  final String pronunciation;
  @JsonKey(name: winRateWritingField)
  final double winRateWriting;
  @JsonKey(name: winRateReadingField)
  final double winRateReading;
  @JsonKey(name: winRateRecognitionField)
  final double winRateRecognition;
  @JsonKey(name: dateAddedField)
  final int dateAdded;

  const Kanji({required this.kanji, required this.listName, required this.meaning,
    required this.pronunciation, this.winRateReading = -1, this.winRateRecognition = -1,
    this.winRateWriting = -1, this.dateAdded = 0
  });

  /// Empty [Kanji]
  static const Kanji empty = Kanji(kanji: "", listName: "", meaning: "", pronunciation: "", dateAdded: 0);

  factory Kanji.fromJson(Map<String, dynamic> json) => _$KanjiFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiToJson(this);
}