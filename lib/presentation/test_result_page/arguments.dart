import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/word/word.dart';

class TestResultArguments {
  final double score;
  final int kanji;
  final int studyMode;
  final int testMode;
  final String listsName;
  final Map<String, List<Map<Word, double>>>? studyList;
  final Map<String, List<Map<GrammarPoint, double>>>? grammarList;

  TestResultArguments({
    required this.score,
    required this.kanji,
    required this.studyMode,
    required this.testMode,
    required this.listsName,
    required this.studyList,
    this.grammarList,
  });
}
