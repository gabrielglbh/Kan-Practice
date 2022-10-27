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
      dateAdded: json['dateAdded'] as int? ?? 0,
      dateLastShown: json['dateLastShown'] as int? ?? 0,
      dateLastShownWriting: json['dateLastShownWriting'] as int? ?? 0,
      dateLastShownReading: json['dateLastShownReading'] as int? ?? 0,
      dateLastShownRecognition: json['dateLastShownRecognition'] as int? ?? 0,
      dateLastShownListening: json['dateLastShownListening'] as int? ?? 0,
      dateLastShownSpeaking: json['dateLastShownSpeaking'] as int? ?? 0,
      category: json['category'] as int? ?? 0,
      repetitions: json['repetitions'] as int? ?? 0,
      previousEaseFactor:
          (json['previousEaseFactor'] as num?)?.toDouble() ?? 2.5,
      previousInterval: json['previousInterval'] as int? ?? 0,
      previousIntervalAsDate: json['previousIntervalAsDate'] as int? ?? 0,
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
      'repetitions': instance.repetitions,
      'previousEaseFactor': instance.previousEaseFactor,
      'previousInterval': instance.previousInterval,
      'previousIntervalAsDate': instance.previousIntervalAsDate,
    };
