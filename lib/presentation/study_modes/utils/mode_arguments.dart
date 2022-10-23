import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/domain/word/word.dart';

class ModeArguments {
  final List<Word> studyList;
  final bool isTest;
  final StudyModes mode;
  final Tests testMode;
  final String testHistoryDisplasyName;
  final String studyModeHeaderDisplayName;

  /// Only used when in listening mode and performing a Number Test.
  /// Defaults to false.
  final bool isNumberTest;

  ModeArguments(
      {required this.studyList,
      required this.isTest,
      required this.mode,
      required this.testMode,
      required this.studyModeHeaderDisplayName,
      this.testHistoryDisplasyName = "",
      this.isNumberTest = false});
}
