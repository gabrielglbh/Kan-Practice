import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';

part 'kanji.g.dart';

@JsonSerializable()
class Kanji {
  final String kanji;
  @JsonKey(name: KanjiTableFields.listNameField)
  final String listName;
  final String meaning;
  final String pronunciation;
  final double winRateWriting;
  final double winRateReading;
  final double winRateRecognition;
  final double winRateListening;
  final int dateAdded;
  final int dateLastShown;
  final int dateLastShownWriting;
  final int dateLastShownReading;
  final int dateLastShownRecognition;
  final int dateLastShownListening;
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

  Kanji copyWithReset() => Kanji(
      kanji: this.kanji,
      listName: this.listName,
      meaning:  this.meaning,
      pronunciation: this.pronunciation,
      winRateWriting: DatabaseConstants.emptyWinRate,
      winRateReading: DatabaseConstants.emptyWinRate,
      winRateRecognition: DatabaseConstants.emptyWinRate,
      winRateListening: DatabaseConstants.emptyWinRate,
      dateLastShownWriting: GeneralUtils.getCurrentMilliseconds(),
      dateLastShownReading: GeneralUtils.getCurrentMilliseconds(),
      dateLastShownRecognition: GeneralUtils.getCurrentMilliseconds(),
      dateLastShownListening: GeneralUtils.getCurrentMilliseconds(),
      dateAdded: this.dateAdded,
      dateLastShown: GeneralUtils.getCurrentMilliseconds(),
      category: this.category
  );
}