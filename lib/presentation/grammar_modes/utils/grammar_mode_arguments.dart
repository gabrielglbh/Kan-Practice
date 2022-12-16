import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';

class GrammarModeArguments {
  final List<GrammarPoint> studyList;
  final bool isTest;
  final GrammarModes mode;
  final Tests testMode;
  final String testHistoryDisplasyName;
  final String studyModeHeaderDisplayName;

  /// Only used when in listening mode and performing a Number Test.
  /// Defaults to false.
  final bool isNumberTest;

  GrammarModeArguments(
      {required this.studyList,
      required this.isTest,
      required this.mode,
      required this.testMode,
      required this.studyModeHeaderDisplayName,
      this.testHistoryDisplasyName = "",
      this.isNumberTest = false});
}
