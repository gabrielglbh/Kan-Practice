import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';

part 'test_result.g.dart';

@JsonSerializable()
class Test {
  @JsonKey(name: takenDateField)
  final int takenDate;
  @JsonKey(name: testScoreField)
  final double testScore;
  @JsonKey(name: kanjiInTestField)
  final int kanjiInTest;
  @JsonKey(name: kanjiListsField)
  final String kanjiLists;
  @JsonKey(name: studyModeField)
  final int studyMode;

  Test({required this.takenDate, required this.testScore, required this.kanjiLists,
    required this.kanjiInTest, required this.studyMode});

  /// Empty [Test]
  static final Test empty = Test(testScore: 0, kanjiInTest: 0, kanjiLists: "", takenDate: 0, studyMode: 0);

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}