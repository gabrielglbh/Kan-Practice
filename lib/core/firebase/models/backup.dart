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

  static const String kanjiLabel = "kanji";
  static const String listLabel = "lists";
  static const String testLabel = "test";
  static const String updatedLabel = "lastUpdated";

  const BackUp(
      {required this.lists,
      required this.kanji,
      required this.test,
      required this.lastUpdated});

  /// Empty instance of [BackUp]
  static const BackUp empty =
      BackUp(lists: [], kanji: [], test: [], lastUpdated: 0);

  factory BackUp.fromJson(Map<String, dynamic> json) => _$BackUpFromJson(json);
  Map<String, dynamic> toJson() => _$BackUpToJson(this);
}
