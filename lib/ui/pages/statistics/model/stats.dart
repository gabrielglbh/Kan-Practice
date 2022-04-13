class KanPracticeStats {
  final int totalLists;
  final int totalKanji;
  final double totalWinRateWriting;
  final double totalWinRateReading;
  final double totalWinRateRecognition;
  final double totalWinRateListening;
  final String bestList;
  final String worstList;
  final int totalTests;
  final double totalTestAccuracy;
  final int testTotalCountWriting;
  final int testTotalCountReading;
  final int testTotalCountRecognition;
  final int testTotalCountListening;
  final double testTotalWinRateWriting;
  final double testTotalWinRateReading;
  final double testTotalWinRateRecognition;
  final double testTotalWinRateListening;
  final int selectionTests;
  final int blitzTests;
  final int remembranceTests;
  final int numberTests;
  final int lessPctTests;
  final int categoryTests;

  KanPracticeStats({
    required this.totalLists,
    required this.totalKanji,
    required this.totalWinRateWriting,
    required this.totalWinRateReading,
    required this.totalWinRateRecognition,
    required this.totalWinRateListening,
    required this.bestList,
    required this.worstList,
    required this.totalTests,
    required this.totalTestAccuracy,
    required this.testTotalCountWriting,
    required this.testTotalCountReading,
    required this.testTotalCountRecognition,
    required this.testTotalCountListening,
    required this.testTotalWinRateWriting,
    required this.testTotalWinRateReading,
    required this.testTotalWinRateRecognition,
    required this.testTotalWinRateListening,
    required this.selectionTests,
    required this.blitzTests,
    required this.remembranceTests,
    required this.numberTests,
    required this.lessPctTests,
    required this.categoryTests
  });
}