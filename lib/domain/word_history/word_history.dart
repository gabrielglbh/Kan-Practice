import 'package:json_annotation/json_annotation.dart';

part 'word_history.g.dart';

@JsonSerializable()
class WordHistory {
  final String word;
  final int searchedOn;

  WordHistory({required this.word, required this.searchedOn});

  /// Empty [WordHistory]
  static final WordHistory empty = WordHistory(word: "", searchedOn: 0);

  factory WordHistory.fromJson(Map<String, dynamic> json) =>
      _$WordHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$WordHistoryToJson(this);
}
