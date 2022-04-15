import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/models/test_result.dart';

part 'backup.g.dart';

@JsonSerializable()
class BackUp {
  final List<KanjiList> lists;
  final List<Kanji> kanji;
  final List<Test> test;
  final int lastUpdated;

  static final String kanjiLabel = "kanji";
  static final String listLabel = "lists";
  static final String testLabel = "test";
  static final String updatedLabel = "lastUpdated";

  const BackUp({required this.lists, required this.kanji,
    required this.test, required this.lastUpdated});

  /// Empty instance of [BackUp]
  static const BackUp empty = BackUp(lists: [], kanji: [], test: [], lastUpdated: 0);

  factory BackUp.fromJson(Map<String, dynamic> json) => _$BackUpFromJson(json);
  Map<String, dynamic> toJson() => _$BackUpToJson(this);
}