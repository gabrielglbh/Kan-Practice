// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordHistory _$HistoryWordFromJson(Map<String, dynamic> json) => WordHistory(
      word: json['word'] as String,
      searchedOn: json['searchedOn'] as int,
    );

Map<String, dynamic> _$HistoryWordToJson(WordHistory instance) =>
    <String, dynamic>{
      'word': instance.word,
      'searchedOn': instance.searchedOn,
    };
