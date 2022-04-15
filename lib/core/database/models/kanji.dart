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
  @JsonKey(name: KanjiTableFields.winRateListeningField)
  final double winRateListening;
  @JsonKey(name: KanjiTableFields.dateAddedField)
  final int dateAdded;
  @JsonKey(name: KanjiTableFields.dateLastShown)
  final int dateLastShown;
  @JsonKey(name: KanjiTableFields.dateLastShownWriting)
  final int dateLastShownWriting;
  @JsonKey(name: KanjiTableFields.dateLastShownReading)
  final int dateLastShownReading;
  @JsonKey(name: KanjiTableFields.dateLastShownRecognition)
  final int dateLastShownRecognition;
  @JsonKey(name: KanjiTableFields.dateLastShownListening)
  final int dateLastShownListening;
  @JsonKey(name: KanjiTableFields.categoryField)
  final int category;

  const Kanji({required this.kanji, required this.listName, required this.meaning,
    required this.pronunciation, this.winRateReading = DatabaseConstants.emptyWinRate,
    this.winRateRecognition = DatabaseConstants.emptyWinRate,
    this.winRateWriting = DatabaseConstants.emptyWinRate,
    this.winRateListening = DatabaseConstants.emptyWinRate, this.dateAdded = 0,
    this.dateLastShown = 0, this.dateLastShownWriting = 0, this.dateLastShownReading = 0,
    this.dateLastShownRecognition = 0, this.dateLastShownListening = 0, this.category = 0
  });

  /// Empty [Kanji]
  static const Kanji empty = Kanji(kanji: "", listName: "", meaning: "", pronunciation: "");

  factory Kanji.fromJson(Map<String, dynamic> json) => _$KanjiFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiToJson(this);

  Kanji copyWithUpdatedDate({int? dateAdded, int? dateLastShown}) => Kanji(
    kanji: this.kanji,
    listName: this.listName,
    meaning:  this.meaning,
    pronunciation: this.pronunciation,
    winRateWriting: this.winRateWriting,
    winRateReading: this.winRateReading,
    winRateRecognition: this.winRateRecognition,
    winRateListening: this.winRateListening,
    dateLastShownWriting: this.dateLastShownWriting,
    dateLastShownReading: this.dateLastShownReading,
    dateLastShownRecognition: this.dateLastShownRecognition,
    dateLastShownListening: this.dateLastShownListening,
    dateAdded: dateAdded ?? this.dateAdded,
    dateLastShown: dateLastShown ?? this.dateLastShown,
    category: this.category
  );
}