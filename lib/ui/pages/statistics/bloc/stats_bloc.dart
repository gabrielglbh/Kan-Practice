import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatisticsBloc extends Bloc<StatsEvent, StatsState> {
  StatisticsBloc() : super(StatisticsLoading()) {
    on<StatisticsEventLoading>((event, emit) async {
      emit(StatisticsLoading());

      final int totalKanji = await KanjiQueries.instance.getTotalKanjiCount();
      final Kanji winRates = await KanjiQueries.instance.getTotalKanjiWinRates();
      final int totalTests = await TestQueries.instance.getTotalTestCount();
      final double totalTestAccuracy = await TestQueries.instance.getTotalTestAccuracy();
      final int testTotalCountWriting = await TestQueries.instance.getTestCountBasedOnStudyMode(0);
      final int testTotalCountReading = await TestQueries.instance.getTestCountBasedOnStudyMode(1);
      final int testTotalCountRecognition = await TestQueries.instance.getTestCountBasedOnStudyMode(2);
      final int testTotalCountListening = await TestQueries.instance.getTestCountBasedOnStudyMode(3);
      final double testTotalWinRateWriting = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(0);
      final double testTotalWinRateReading = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(1);
      final double testTotalWinRateRecognition = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(2);
      final double testTotalWinRateListening = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(3);

      emit(StatisticsLoaded(stats: KanPracticeStats(
          totalKanji: totalKanji,
          totalWinRateWriting: winRates.winRateWriting,
          totalWinRateReading: winRates.winRateReading,
          totalWinRateRecognition: winRates.winRateRecognition,
          totalWinRateListening: winRates.winRateListening,
          totalTests: totalTests,
          totalTestAccuracy: totalTestAccuracy,
          testTotalCountWriting: testTotalCountWriting,
          testTotalCountReading: testTotalCountReading,
          testTotalCountRecognition: testTotalCountRecognition,
          testTotalCountListening: testTotalCountListening,
          testTotalWinRateWriting: testTotalWinRateWriting,
          testTotalWinRateReading: testTotalWinRateReading,
          testTotalWinRateRecognition: testTotalWinRateRecognition,
          testTotalWinRateListening: testTotalWinRateListening
      )));
    });
  }
}