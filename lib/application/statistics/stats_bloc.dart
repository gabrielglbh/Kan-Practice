import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'stats_event.dart';
part 'stats_state.dart';

@lazySingleton
class StatisticsBloc extends Bloc<StatsEvent, StatsState> {
  final IListRepository _listRepository;
  final IWordRepository _wordRepository;
  final ITestDataRepository _testDataRepository;

  StatisticsBloc(
    this._listRepository,
    this._wordRepository,
    this._testDataRepository,
  ) : super(StatisticsIdle()) {
    on<StatisticsEventLoading>((event, emit) async {
      emit(StatisticsLoading());

      final int totalLists = await _listRepository.getTotalListCount();
      final int totalWords = await _wordRepository.getTotalWordCount();
      final Word winRates = await _wordRepository.getTotalWordsWinRates();
      final List<String> lists = await _listRepository.getBestAndWorstList();
      final TestData test = await _testDataRepository.getTestDataFromDb();
      final List<int> totalCategoryCounts =
          await _wordRepository.getWordsFromCategory();

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
