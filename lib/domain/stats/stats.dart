import 'package:kanpractice/domain/test_data/test_data.dart';

class KanPracticeStats {
  final int totalLists;
  final int totalWords;
  final int totalGrammar;
  final double totalWinRateWriting;
  final double totalWinRateReading;
  final double totalWinRateRecognition;
  final double totalWinRateListening;
  final double totalWinRateSpeaking;
  final double totalWinRateDefinition;
  final String bestList;
  final String worstList;
  final TestData test;
  final List<int> totalCategoryCounts;

  KanPracticeStats({
    required this.totalLists,
    required this.totalWords,
    required this.totalGrammar,
    required this.totalWinRateWriting,
    required this.totalWinRateReading,
    required this.totalWinRateRecognition,
    required this.totalWinRateListening,
    required this.totalWinRateSpeaking,
    required this.totalWinRateDefinition,
    required this.bestList,
    required this.worstList,
    required this.test,
    required this.totalCategoryCounts,
  });
}
