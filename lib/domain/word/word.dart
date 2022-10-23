import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
  final String word;
  @JsonKey(name: WordTableFields.listNameField)
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

  const Word(
      {required this.word,
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

  /// Empty [Word]
  static const Word empty =
      Word(word: "", listName: "", meaning: "", pronunciation: "");

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);

  Word copyWithUpdatedDate({int? dateAdded, int? dateLastShown}) => Word(
      word: word,
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

  Word copyWithReset() => Word(
      word: word,
      listName: listName,
      meaning: meaning,
      pronunciation: pronunciation,
      winRateWriting: DatabaseConstants.emptyWinRate,
      winRateReading: DatabaseConstants.emptyWinRate,
      winRateRecognition: DatabaseConstants.emptyWinRate,
      winRateListening: DatabaseConstants.emptyWinRate,
      winRateSpeaking: DatabaseConstants.emptyWinRate,
      dateLastShownWriting: Utils.getCurrentMilliseconds(),
      dateLastShownReading: Utils.getCurrentMilliseconds(),
      dateLastShownRecognition: Utils.getCurrentMilliseconds(),
      dateLastShownListening: Utils.getCurrentMilliseconds(),
      dateLastShownSpeaking: Utils.getCurrentMilliseconds(),
      dateAdded: dateAdded,
      dateLastShown: Utils.getCurrentMilliseconds(),
      category: category);
}
