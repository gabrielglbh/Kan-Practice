import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/word/word.dart';

class TestResultArguments {
  final double score;
  final int word;
  final int? studyMode;
  final int? grammarMode;
  final int testMode;
  final String listsName;
  final bool alterTest;
  final Map<String, List<Map<Word, double>>>? studyList;
  final Map<String, List<Map<GrammarPoint, double>>>? grammarList;

  TestResultArguments({
    required this.score,
    required this.word,
    this.studyMode,
    this.grammarMode,
    required this.testMode,
    required this.listsName,
    this.studyList,
    this.grammarList,
    this.alterTest = false,
  }) : assert((studyMode != null &&
                studyList != null &&
                grammarMode == null &&
                grammarList == null) ||
            (studyMode == null &&
                studyList == null &&
                grammarMode != null &&
                grammarList != null) ||
            alterTest);
}
