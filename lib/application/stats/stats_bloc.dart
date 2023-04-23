import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'stats_event.dart';
part 'stats_state.dart';

part 'stats_bloc.freezed.dart';

@injectable
class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final IListRepository _listRepository;
  final IWordRepository _wordRepository;
  final ITestDataRepository _testDataRepository;
  final IGrammarPointRepository _grammarPointRepository;

  StatsBloc(
    this._listRepository,
    this._wordRepository,
    this._testDataRepository,
    this._grammarPointRepository,
  ) : super(const StatsState.initial()) {
    on<StatsEventLoading>((event, emit) async {
      emit(const StatsState.loading());

      final int totalLists = await _listRepository.getTotalListCount();
      final int totalWords = await _wordRepository.getTotalWordCount();
      final int totalGrammar =
          await _grammarPointRepository.getTotalGrammarPointCount();
      final Word winRates = await _wordRepository.getTotalWordsWinRates();
      final GrammarPoint winRatesGrammar =
          await _grammarPointRepository.getTotalGrammarPointsWinRates();
      final List<String> lists = await _listRepository.getBestAndWorstList();
      final TestData test = await _testDataRepository.getTestDataFromDb();
      final List<int> totalCategoryCounts =
          await _wordRepository.getWordsFromCategory();

      emit(StatsState.loaded(
        KanPracticeStats(
          totalLists: totalLists,
          totalWords: totalWords,
          totalGrammar: totalGrammar,
          totalWinRateWriting: winRates.winRateWriting,
          totalWinRateReading: winRates.winRateReading,
          totalWinRateRecognition: winRates.winRateRecognition,
          totalWinRateListening: winRates.winRateListening,
          totalWinRateSpeaking: winRates.winRateSpeaking,
          totalWinRateDefinition: winRatesGrammar.winRateDefinition,
          totalWinRateGrammarPoint: winRatesGrammar.winRateGrammarPoint,
          bestList: lists[0],
          worstList: lists[1],
          test: test,
          totalCategoryCounts: totalCategoryCounts,
        ),
      ));
    });
  }
}
