// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryWord _$HistoryWordFromJson(Map<String, dynamic> json) => HistoryWord(
      word: json['word'] as String,
      searchedOn: json['searchedOn'] as int,
    );

Map<String, dynamic> _$HistoryWordToJson(HistoryWord instance) =>
    <String, dynamic>{
      'word': instance.word,
      'searchedOn': instance.searchedOn,
    };
