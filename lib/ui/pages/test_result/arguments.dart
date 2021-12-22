import 'package:kanpractice/core/database/models/kanji.dart';

class TestResultArguments {
  final double score;
  final int kanji;
  final int studyMode;
  final String listsName;
  final Map<String, List<Map<Kanji, double>>> studyList;

  TestResultArguments({required this.score, required this.kanji,
    required this.studyMode, required this.listsName, required this.studyList});
}