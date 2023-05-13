import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
  @JsonKey(name: WordTableFields.wordField)
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
  final int repetitionsWriting;
  final double previousEaseFactorWriting;
  final int previousIntervalWriting;
  final int previousIntervalAsDateWriting;
  final int repetitionsReading;
  final double previousEaseFactorReading;
  final int previousIntervalReading;
  final int previousIntervalAsDateReading;
  final int repetitionsRecognition;
  final double previousEaseFactorRecognition;
  final int previousIntervalRecognition;
  final int previousIntervalAsDateRecognition;
  final int repetitionsListening;
  final double previousEaseFactorListening;
  final int previousIntervalListening;
  final int previousIntervalAsDateListening;
  final int repetitionsSpeaking;
  final double previousEaseFactorSpeaking;
  final int previousIntervalSpeaking;
  final int previousIntervalAsDateSpeaking;

  const Word({
    required this.word,
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
    this.category = 0,
    this.repetitionsWriting = 0,
    this.previousEaseFactorWriting = 2.5,
    this.previousIntervalWriting = 0,
    this.previousIntervalAsDateWriting = 0,
    this.repetitionsReading = 0,
    this.previousEaseFactorReading = 2.5,
    this.previousIntervalReading = 0,
    this.previousIntervalAsDateReading = 0,
    this.repetitionsRecognition = 0,
    this.previousEaseFactorRecognition = 2.5,
    this.previousIntervalRecognition = 0,
    this.previousIntervalAsDateRecognition = 0,
    this.repetitionsListening = 0,
    this.previousEaseFactorListening = 2.5,
    this.previousIntervalListening = 0,
    this.previousIntervalAsDateListening = 0,
    this.repetitionsSpeaking = 0,
    this.previousEaseFactorSpeaking = 2.5,
    this.previousIntervalSpeaking = 0,
    this.previousIntervalAsDateSpeaking = 0,
  });

  /// Empty [Word]
  static const Word empty =
      Word(word: "", listName: "", meaning: "", pronunciation: "");

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);

  @override
  bool operator ==(other) {
    if (other is! Word) return false;
    return word == other.word &&
        meaning == other.meaning &&
        pronunciation == other.pronunciation &&
        category == other.category;
  }

  @override
  int get hashCode =>
      (word + meaning + pronunciation + category.toString()).hashCode;

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
        category: category,
        repetitionsWriting: repetitionsWriting,
        previousEaseFactorWriting: previousEaseFactorWriting,
        previousIntervalWriting: previousIntervalWriting,
        previousIntervalAsDateWriting: previousIntervalAsDateWriting,
        repetitionsReading: repetitionsReading,
        previousEaseFactorReading: previousEaseFactorReading,
        previousIntervalReading: previousIntervalReading,
        previousIntervalAsDateReading: previousIntervalAsDateReading,
        repetitionsRecognition: repetitionsRecognition,
        previousEaseFactorRecognition: previousEaseFactorRecognition,
        previousIntervalRecognition: previousIntervalRecognition,
        previousIntervalAsDateRecognition: previousIntervalAsDateRecognition,
        repetitionsListening: repetitionsListening,
        previousEaseFactorListening: previousEaseFactorListening,
        previousIntervalListening: previousIntervalListening,
        previousIntervalAsDateListening: previousIntervalAsDateListening,
        repetitionsSpeaking: repetitionsSpeaking,
        previousEaseFactorSpeaking: previousEaseFactorSpeaking,
        previousIntervalSpeaking: previousIntervalSpeaking,
        previousIntervalAsDateSpeaking: previousIntervalAsDateSpeaking,
      );

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
        category: category,
        repetitionsWriting: 0,
        previousEaseFactorWriting: 2.5,
        previousIntervalWriting: 0,
        previousIntervalAsDateWriting: 0,
        repetitionsReading: 0,
        previousEaseFactorReading: 2.5,
        previousIntervalReading: 0,
        previousIntervalAsDateReading: 0,
        repetitionsRecognition: 0,
        previousEaseFactorRecognition: 2.5,
        previousIntervalRecognition: 0,
        previousIntervalAsDateRecognition: 0,
        repetitionsListening: 0,
        previousEaseFactorListening: 2.5,
        previousIntervalListening: 0,
        previousIntervalAsDateListening: 0,
        repetitionsSpeaking: 0,
        previousEaseFactorSpeaking: 2.5,
        previousIntervalSpeaking: 0,
        previousIntervalAsDateSpeaking: 0,
      );

  Word copyWithTranslation({String? meaning}) => Word(
        word: word,
        listName: listName,
        meaning: meaning ?? this.meaning,
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
        dateAdded: dateAdded,
        dateLastShown: dateLastShown,
        category: category,
        repetitionsWriting: repetitionsWriting,
        previousEaseFactorWriting: previousEaseFactorWriting,
        previousIntervalWriting: previousIntervalWriting,
        previousIntervalAsDateWriting: previousIntervalAsDateWriting,
        repetitionsReading: repetitionsReading,
        previousEaseFactorReading: previousEaseFactorReading,
        previousIntervalReading: previousIntervalReading,
        previousIntervalAsDateReading: previousIntervalAsDateReading,
        repetitionsRecognition: repetitionsRecognition,
        previousEaseFactorRecognition: previousEaseFactorRecognition,
        previousIntervalRecognition: previousIntervalRecognition,
        previousIntervalAsDateRecognition: previousIntervalAsDateRecognition,
        repetitionsListening: repetitionsListening,
        previousEaseFactorListening: previousEaseFactorListening,
        previousIntervalListening: previousIntervalListening,
        previousIntervalAsDateListening: previousIntervalAsDateListening,
        repetitionsSpeaking: repetitionsSpeaking,
        previousEaseFactorSpeaking: previousEaseFactorSpeaking,
        previousIntervalSpeaking: previousIntervalSpeaking,
        previousIntervalAsDateSpeaking: previousIntervalAsDateSpeaking,
      );
}
