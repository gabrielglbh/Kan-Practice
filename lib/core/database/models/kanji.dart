import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/ui/general_utils.dart';

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
  final double winRateSpeaking;
  final int dateAdded;
  final int dateLastShown;
  final int dateLastShownWriting;
  final int dateLastShownReading;
  final int dateLastShownRecognition;
  final int dateLastShownListening;
  final int dateLastShownSpeaking;
  final int category;

  const Kanji(
      {required this.kanji,
      required this.listName,
      required this.meaning,
      required this.pronunciation,
      this.winRateReading = DatabaseConstants.emptyWinRate,
      this.winRateRecognition = DatabaseConstants.emptyWinRate,
      this.winRateWriting = DatabaseConstants.emptyWinRate,
      this.winRateListening = DatabaseConstants.emptyWinRate,
      this.winRateSpeaking = DatabaseConstants.emptyWinRate,
      this.dateAdded = 0,
      this.dateLastShown = 0,
      this.dateLastShownWriting = 0,
      this.dateLastShownReading = 0,
      this.dateLastShownRecognition = 0,
      this.dateLastShownListening = 0,
      this.dateLastShownSpeaking = 0,
      this.category = 0});

  /// Empty [Kanji]
  static const Kanji empty =
      Kanji(kanji: "", listName: "", meaning: "", pronunciation: "");

  factory Kanji.fromJson(Map<String, dynamic> json) => _$KanjiFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiToJson(this);

  Kanji copyWithUpdatedDate({int? dateAdded, int? dateLastShown}) => Kanji(
      kanji: kanji,
      listName: listName,
      meaning: meaning,
      pronunciation: pronunciation,
      winRateWriting: winRateWriting,
      winRateReading: winRateReading,
      winRateRecognition: winRateRecognition,
      winRateListening: winRateListening,
      winRateSpeaking: winRateSpeaking,
      dateLastShownWriting: dateLastShownWriting,
      dateLastShownReading: dateLastShownReading,
      dateLastShownRecognition: dateLastShownRecognition,
      dateLastShownListening: dateLastShownListening,
      dateLastShownSpeaking: dateLastShownSpeaking,
      dateAdded: dateAdded ?? this.dateAdded,
      dateLastShown: dateLastShown ?? this.dateLastShown,
      category: category);

  Kanji copyWithReset() => Kanji(
      kanji: kanji,
      listName: listName,
      meaning: meaning,
      pronunciation: pronunciation,
      winRateWriting: DatabaseConstants.emptyWinRate,
      winRateReading: DatabaseConstants.emptyWinRate,
      winRateRecognition: DatabaseConstants.emptyWinRate,
      winRateListening: DatabaseConstants.emptyWinRate,
      winRateSpeaking: DatabaseConstants.emptyWinRate,
      dateLastShownWriting: GeneralUtils.getCurrentMilliseconds(),
      dateLastShownReading: GeneralUtils.getCurrentMilliseconds(),
      dateLastShownRecognition: GeneralUtils.getCurrentMilliseconds(),
      dateLastShownListening: GeneralUtils.getCurrentMilliseconds(),
      dateLastShownSpeaking: GeneralUtils.getCurrentMilliseconds(),
      dateAdded: dateAdded,
      dateLastShown: GeneralUtils.getCurrentMilliseconds(),
      category: category);
}
