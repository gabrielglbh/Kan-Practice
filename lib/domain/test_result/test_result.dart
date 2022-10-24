import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/application/services/database_consts.dart';

part 'test_result.g.dart';

@JsonSerializable()
class Test {
  final int takenDate;
  @JsonKey(name: TestTableFields.testScoreField)
  final double testScore;
  @JsonKey(name: TestTableFields.wordsInTestField)
  final int wordsInTest;
  @JsonKey(name: TestTableFields.wordsListsField)
  final String lists;
  final int? testMode;
  final int studyMode;

  Test(
      {required this.takenDate,
      required this.testScore,
      required this.lists,
      required this.wordsInTest,
      required this.studyMode,
      this.testMode = -1});

  /// Empty [Test]
  static final Test empty = Test(
      testScore: 0,
      wordsInTest: 0,
      lists: "",
      takenDate: 0,
      studyMode: 0,
      testMode: 0);

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}
