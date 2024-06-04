import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/word/word.dart';

extension EmptyList on Iterable<double> {
  List<double> populateIfEmpty() {
    if (isEmpty) return [0];
    return toList();
  }
}

extension WordMeanCalc on List<Word> {
  // TODO: If a new StudyMode is added, modify this
  Map<String, double> studyModesMean() {
    final totalWriting = map<double>((word) => word.winRateWriting)
        .toList()
        .where((winRate) => winRate != DatabaseConstants.emptyWinRate)
        .populateIfEmpty()
        .reduce((a, b) => a + b);
    final totalReading = map<double>((word) => word.winRateReading)
        .toList()
        .where((winRate) => winRate != DatabaseConstants.emptyWinRate)
        .populateIfEmpty()
        .reduce((a, b) => a + b);
    final totalRecognition = map<double>((word) => word.winRateRecognition)
        .toList()
        .where((winRate) => winRate != DatabaseConstants.emptyWinRate)
        .populateIfEmpty()
        .reduce((a, b) => a + b);
    final totalListening = map<double>((word) => word.winRateListening)
        .toList()
        .where((winRate) => winRate != DatabaseConstants.emptyWinRate)
        .populateIfEmpty()
        .reduce((a, b) => a + b);
    final totalSpeaking = map<double>((word) => word.winRateSpeaking)
        .toList()
        .where((winRate) => winRate != DatabaseConstants.emptyWinRate)
        .populateIfEmpty()
        .reduce((a, b) => a + b);

    return {
      ListTableFields.totalWinRateWritingField: totalWriting / length,
      ListTableFields.totalWinRateReadingField: totalReading / length,
      ListTableFields.totalWinRateRecognitionField: totalRecognition / length,
      ListTableFields.totalWinRateListeningField: totalListening / length,
      ListTableFields.totalWinRateSpeakingField: totalSpeaking / length,
    };
  }
}

extension GrammarPointMeanCalc on List<GrammarPoint> {
  // TODO: If a new GrammarMode is added, modify this
  Map<String, double> grammarModesMean() {
    final totalDefinition = map<double>((word) => word.winRateDefinition)
        .toList()
        .where((winRate) => winRate != DatabaseConstants.emptyWinRate)
        .populateIfEmpty()
        .reduce((a, b) => a + b);
    final totalGrammarPoints = map<double>((word) => word.winRateGrammarPoint)
        .toList()
        .where((winRate) => winRate != DatabaseConstants.emptyWinRate)
        .populateIfEmpty()
        .reduce((a, b) => a + b);

    return {
      ListTableFields.totalWinRateDefinitionField: totalDefinition / length,
      ListTableFields.totalWinRateGrammarPointField:
          totalGrammarPoints / length,
    };
  }
}
