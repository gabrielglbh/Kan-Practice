import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';

class ModeArguments {
  final List<Kanji> studyList;
  final bool isTest;
  final StudyModes mode;
  final Tests testMode;
  final String listsNames;
  final String display;

  /// Only used when in listening mode and performing a Number Test.
  /// Defaults to false.
  final bool isNumberTest;

  ModeArguments(
      {required this.studyList,
      required this.isTest,
      required this.mode,
      required this.testMode,
      required this.display,
      this.listsNames = "",
      this.isNumberTest = false});
}
