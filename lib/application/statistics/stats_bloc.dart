import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/infrastructure/list/list_repository_impl.dart';
import 'package:kanpractice/infrastructure/test_data/test_data_repository_impl.dart';
import 'package:kanpractice/infrastructure/word/word_repository_impl.dart';
import 'package:kanpractice/injection.dart';

part 'stats_event.dart';
part 'stats_state.dart';

@lazySingleton
class StatisticsBloc extends Bloc<StatsEvent, StatsState> {
  StatisticsBloc() : super(StatisticsLoading()) {
    on<StatisticsEventLoading>((event, emit) async {
      emit(StatisticsLoading());

      final int totalLists =
          await getIt<ListRepositoryImpl>().getTotalListCount();
      final int totalWords =
          await getIt<WordRepositoryImpl>().getTotalWordCount();
      final Word winRates =
          await getIt<WordRepositoryImpl>().getTotalWordsWinRates();
      final List<String> lists =
          await getIt<ListRepositoryImpl>().getBestAndWorstList();
      final TestData test =
          await getIt<TestDataRepositoryImpl>().getTestDataFromDb();
      final List<int> totalCategoryCounts =
          await getIt<WordRepositoryImpl>().getWordsFromCategory();

      emit(StatisticsLoaded(
        stats: KanPracticeStats(
          totalLists: totalLists,
          totalWords: totalWords,
          totalWinRateWriting: winRates.winRateWriting,
          totalWinRateReading: winRates.winRateReading,
          totalWinRateRecognition: winRates.winRateRecognition,
          totalWinRateListening: winRates.winRateListening,
          totalWinRateSpeaking: winRates.winRateSpeaking,
          bestList: lists[0],
          worstList: lists[1],
          test: test,
          totalCategoryCounts: totalCategoryCounts,
        ),
      ));
    });
  }
}
