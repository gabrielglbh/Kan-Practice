import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/types/learning_mode.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';

class ModeArguments {
  final List<Kanji> studyList;
  final bool isTest;
  final StudyModes mode;
  final LearningMode learningMode;
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
      this.learningMode = LearningMode.spatial,
      this.testHistoryDisplasyName = "",
      this.isNumberTest = false});
}
