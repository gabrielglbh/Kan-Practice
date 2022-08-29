import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/test_data.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatisticsBloc extends Bloc<StatsEvent, StatsState> {
  StatisticsBloc() : super(StatisticsLoading()) {
    on<StatisticsEventLoading>((event, emit) async {
      emit(StatisticsLoading());

      final int totalLists = await ListQueries.instance.getTotalListCount();
      final int totalKanji = await KanjiQueries.instance.getTotalKanjiCount();
      final Kanji winRates =
          await KanjiQueries.instance.getTotalKanjiWinRates();
      final List<String> lists =
          await ListQueries.instance.getBestAndWorstList();
      final TestData test = await TestQueries.instance.getTestDataFromDb();

      emit(StatisticsLoaded(
        stats: KanPracticeStats(
          totalLists: totalLists,
          totalKanji: totalKanji,
          totalWinRateWriting: winRates.winRateWriting,
          totalWinRateReading: winRates.winRateReading,
          totalWinRateRecognition: winRates.winRateRecognition,
          totalWinRateListening: winRates.winRateListening,
          totalWinRateSpeaking: winRates.winRateSpeaking,
          bestList: lists[0],
          worstList: lists[1],
          test: test,
        ),
      ));
    });
  }
}
