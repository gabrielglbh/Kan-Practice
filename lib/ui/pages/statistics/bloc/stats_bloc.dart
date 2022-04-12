import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/utils/types/study_modes.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatisticsBloc extends Bloc<StatsEvent, StatsState> {
  StatisticsBloc() : super(StatisticsLoading()) {
    on<StatisticsEventLoading>((event, emit) async {
      emit(StatisticsLoading());

      final int totalLists = await ListQueries.instance.getTotalListCount();
      final int totalKanji = await KanjiQueries.instance.getTotalKanjiCount();
      final Kanji winRates = await KanjiQueries.instance.getTotalKanjiWinRates();
      final List<String> lists = await ListQueries.instance.getBestAndWorstList();
      final int totalTests = await TestQueries.instance.getTotalTestCount();
      final double totalTestAccuracy = await TestQueries.instance.getTotalTestAccuracy();
      final int testTotalCountWriting = await TestQueries.instance.getTestCountBasedOnStudyMode(
          StudyModes.writing.map);
      final int testTotalCountReading = await TestQueries.instance.getTestCountBasedOnStudyMode(
          StudyModes.reading.map);
      final int testTotalCountRecognition = await TestQueries.instance.getTestCountBasedOnStudyMode(
          StudyModes.recognition.map);
      final int testTotalCountListening = await TestQueries.instance.getTestCountBasedOnStudyMode(
          StudyModes.listening.map);
      final double testTotalWinRateWriting = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(
          StudyModes.writing.map);
      final double testTotalWinRateReading = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(
          StudyModes.reading.map);
      final double testTotalWinRateRecognition = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(
          StudyModes.recognition.map);
      final double testTotalWinRateListening = await TestQueries.instance.getTestAccuracyBasedOnStudyMode(
          StudyModes.listening.map);
      final List<int> testModesCount = await TestQueries.instance.getAllTestsBasedOnTestMode();

      emit(StatisticsLoaded(stats: KanPracticeStats(
          totalLists: totalLists,
          totalKanji: totalKanji,
          totalWinRateWriting: winRates.winRateWriting,
          totalWinRateReading: winRates.winRateReading,
          totalWinRateRecognition: winRates.winRateRecognition,
          totalWinRateListening: winRates.winRateListening,
          bestList: lists[0],
          worstList: lists[1],
          totalTests: totalTests,
          totalTestAccuracy: totalTestAccuracy,
          testTotalCountWriting: testTotalCountWriting,
          testTotalCountReading: testTotalCountReading,
          testTotalCountRecognition: testTotalCountRecognition,
          testTotalCountListening: testTotalCountListening,
          testTotalWinRateWriting: testTotalWinRateWriting,
          testTotalWinRateReading: testTotalWinRateReading,
          testTotalWinRateRecognition: testTotalWinRateRecognition,
          testTotalWinRateListening: testTotalWinRateListening,
          selectionTests: testModesCount[0],
          blitzTests: testModesCount[1],
          remembranceTests: testModesCount[2],
          numberTests: testModesCount[3],
          lessPctTests: testModesCount[4]
      )));
    });
  }
}