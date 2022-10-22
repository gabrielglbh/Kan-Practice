import 'package:kanpractice/domain/word/word.dart';

class TestResultArguments {
  final double score;
  final int kanji;
  final int studyMode;
  final int testMode;
  final String listsName;
  final Map<String, List<Map<Word, double>>>? studyList;

  TestResultArguments(
      {required this.score,
      required this.kanji,
      required this.studyMode,
      required this.testMode,
      required this.listsName,
      required this.studyList});
}
