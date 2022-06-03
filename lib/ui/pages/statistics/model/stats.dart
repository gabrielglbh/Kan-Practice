import 'package:kanpractice/core/firebase/models/test_data.dart';

class KanPracticeStats {
  final int totalLists;
  final int totalKanji;
  final double totalWinRateWriting;
  final double totalWinRateReading;
  final double totalWinRateRecognition;
  final double totalWinRateListening;
  final String bestList;
  final String worstList;
  final TestData test;

  KanPracticeStats(
      {required this.totalLists,
      required this.totalKanji,
      required this.totalWinRateWriting,
      required this.totalWinRateReading,
      required this.totalWinRateRecognition,
      required this.totalWinRateListening,
      required this.bestList,
      required this.worstList,
      required this.test});
}
