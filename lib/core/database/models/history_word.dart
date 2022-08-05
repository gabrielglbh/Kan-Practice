import 'package:json_annotation/json_annotation.dart';

part 'history_word.g.dart';

@JsonSerializable()
class HistoryWord {
  final String word;
  final int searchedOn;

  HistoryWord({required this.word, required this.searchedOn});

  /// Empty [HistoryWord]
  static final HistoryWord empty = HistoryWord(word: "", searchedOn: 0);

  factory HistoryWord.fromJson(Map<String, dynamic> json) =>
      _$HistoryWordFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryWordToJson(this);
}
