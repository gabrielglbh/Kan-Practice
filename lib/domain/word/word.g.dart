// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      word: json['kanji'] as String,
      listName: json['name'] as String,
      meaning: json['meaning'] as String,
      pronunciation: json['pronunciation'] as String,
      winRateReading: (json['winRateReading'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      winRateRecognition: (json['winRateRecognition'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      winRateWriting: (json['winRateWriting'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      winRateListening: (json['winRateListening'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      winRateSpeaking: (json['winRateSpeaking'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      dateAdded: (json['dateAdded'] as num?)?.toInt() ?? 0,
      dateLastShown: (json['dateLastShown'] as num?)?.toInt() ?? 0,
      dateLastShownWriting:
          (json['dateLastShownWriting'] as num?)?.toInt() ?? 0,
      dateLastShownReading:
          (json['dateLastShownReading'] as num?)?.toInt() ?? 0,
      dateLastShownRecognition:
          (json['dateLastShownRecognition'] as num?)?.toInt() ?? 0,
      dateLastShownListening:
          (json['dateLastShownListening'] as num?)?.toInt() ?? 0,
      dateLastShownSpeaking:
          (json['dateLastShownSpeaking'] as num?)?.toInt() ?? 0,
      category: (json['category'] as num?)?.toInt() ?? 0,
      repetitionsWriting: (json['repetitionsWriting'] as num?)?.toInt() ?? 0,
      previousEaseFactorWriting:
          (json['previousEaseFactorWriting'] as num?)?.toDouble() ?? 2.5,
      previousIntervalWriting:
          (json['previousIntervalWriting'] as num?)?.toInt() ?? 0,
      previousIntervalAsDateWriting:
          (json['previousIntervalAsDateWriting'] as num?)?.toInt() ?? 0,
      repetitionsReading: (json['repetitionsReading'] as num?)?.toInt() ?? 0,
      previousEaseFactorReading:
          (json['previousEaseFactorReading'] as num?)?.toDouble() ?? 2.5,
      previousIntervalReading:
          (json['previousIntervalReading'] as num?)?.toInt() ?? 0,
      previousIntervalAsDateReading:
          (json['previousIntervalAsDateReading'] as num?)?.toInt() ?? 0,
      repetitionsRecognition:
          (json['repetitionsRecognition'] as num?)?.toInt() ?? 0,
      previousEaseFactorRecognition:
          (json['previousEaseFactorRecognition'] as num?)?.toDouble() ?? 2.5,
      previousIntervalRecognition:
          (json['previousIntervalRecognition'] as num?)?.toInt() ?? 0,
      previousIntervalAsDateRecognition:
          (json['previousIntervalAsDateRecognition'] as num?)?.toInt() ?? 0,
      repetitionsListening:
          (json['repetitionsListening'] as num?)?.toInt() ?? 0,
      previousEaseFactorListening:
          (json['previousEaseFactorListening'] as num?)?.toDouble() ?? 2.5,
      previousIntervalListening:
          (json['previousIntervalListening'] as num?)?.toInt() ?? 0,
      previousIntervalAsDateListening:
          (json['previousIntervalAsDateListening'] as num?)?.toInt() ?? 0,
      repetitionsSpeaking: (json['repetitionsSpeaking'] as num?)?.toInt() ?? 0,
      previousEaseFactorSpeaking:
          (json['previousEaseFactorSpeaking'] as num?)?.toDouble() ?? 2.5,
      previousIntervalSpeaking:
          (json['previousIntervalSpeaking'] as num?)?.toInt() ?? 0,
      previousIntervalAsDateSpeaking:
          (json['previousIntervalAsDateSpeaking'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'kanji': instance.word,
      'name': instance.listName,
      'meaning': instance.meaning,
      'pronunciation': instance.pronunciation,
      'winRateWriting': instance.winRateWriting,
      'winRateReading': instance.winRateReading,
      'winRateRecognition': instance.winRateRecognition,
      'winRateListening': instance.winRateListening,
      'winRateSpeaking': instance.winRateSpeaking,
      'dateAdded': instance.dateAdded,
      'dateLastShown': instance.dateLastShown,
      'dateLastShownWriting': instance.dateLastShownWriting,
      'dateLastShownReading': instance.dateLastShownReading,
      'dateLastShownRecognition': instance.dateLastShownRecognition,
      'dateLastShownListening': instance.dateLastShownListening,
      'dateLastShownSpeaking': instance.dateLastShownSpeaking,
      'category': instance.category,
      'repetitionsWriting': instance.repetitionsWriting,
      'previousEaseFactorWriting': instance.previousEaseFactorWriting,
      'previousIntervalWriting': instance.previousIntervalWriting,
      'previousIntervalAsDateWriting': instance.previousIntervalAsDateWriting,
      'repetitionsReading': instance.repetitionsReading,
      'previousEaseFactorReading': instance.previousEaseFactorReading,
      'previousIntervalReading': instance.previousIntervalReading,
      'previousIntervalAsDateReading': instance.previousIntervalAsDateReading,
      'repetitionsRecognition': instance.repetitionsRecognition,
      'previousEaseFactorRecognition': instance.previousEaseFactorRecognition,
      'previousIntervalRecognition': instance.previousIntervalRecognition,
      'previousIntervalAsDateRecognition':
          instance.previousIntervalAsDateRecognition,
      'repetitionsListening': instance.repetitionsListening,
      'previousEaseFactorListening': instance.previousEaseFactorListening,
      'previousIntervalListening': instance.previousIntervalListening,
      'previousIntervalAsDateListening':
          instance.previousIntervalAsDateListening,
      'repetitionsSpeaking': instance.repetitionsSpeaking,
      'previousEaseFactorSpeaking': instance.previousEaseFactorSpeaking,
      'previousIntervalSpeaking': instance.previousIntervalSpeaking,
      'previousIntervalAsDateSpeaking': instance.previousIntervalAsDateSpeaking,
    };
