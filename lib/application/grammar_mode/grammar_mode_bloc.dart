import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/services/sm2_algorithm.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'grammar_mode_event.dart';
part 'grammar_mode_state.dart';

part 'grammar_mode_bloc.freezed.dart';

@lazySingleton
class GrammarModeBloc extends Bloc<GrammarModeEvent, GrammarModeState> {
  final IGrammarPointRepository _grammarPointRepository;
  final IListRepository _listRepository;

  GrammarModeBloc(
    this._grammarPointRepository,
    this._listRepository,
  ) : super(const GrammarModeState.loaded()) {
    on<GrammarModeEventCalculateScore>((event, emit) async {
      double actualScore = 0;
      Map<String, dynamic> toUpdate = {};

      /// If winRate of any mode is -1, it means that the user has not studied this
      /// word yet. Therefore, the score should be untouched.
      /// If the winRate is different than -1, the user has already studied this word
      /// and then, a mean is calculated between the upcoming score and the previous one.
      switch (event.mode) {
        case GrammarModes.definition:
          if (event.grammarPoint.winRateDefinition ==
              DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore =
                (event.score + event.grammarPoint.winRateDefinition) / 2;
          }
          toUpdate = {GrammarTableFields.winRateDefinitionField: actualScore};
          break;
        case GrammarModes.grammarPoints:
          if (event.grammarPoint.winRateGrammarPoint ==
              DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore =
                (event.score + event.grammarPoint.winRateGrammarPoint) / 2;
          }
          toUpdate = {GrammarTableFields.winRateGrammarPointField: actualScore};
          break;
      }
      final res = await _grammarPointRepository.updateGrammarPoint(
          event.grammarPoint.listName, event.grammarPoint.name, toUpdate);
      emit(GrammarModeState.scoreCalculated(res));
    });

    on<GrammarModeEventCalculateSM2Params>((event, emit) async {
      Map<String, dynamic> toUpdate = {};

      switch (event.mode) {
        case GrammarModes.definition:
          final sm2 = SMAlgorithm.calc(
            quality: event.score,
            repetitions: event.grammarPoint.repetitionsDefinition,
            previousInterval: event.grammarPoint.previousIntervalDefinition,
            previousEaseFactor: event.grammarPoint.previousEaseFactorDefinition,
          );
          toUpdate = {
            GrammarTableFields.previousIntervalDefinitionField: sm2.interval,
            GrammarTableFields.previousIntervalAsDateDefinitionField:
                sm2.intervalAsDate,
            GrammarTableFields.repetitionsDefinitionField: sm2.repetitions,
            GrammarTableFields.previousEaseFactorDefinitionField:
                sm2.easeFactor,
          };
          break;
        case GrammarModes.grammarPoints:
          final sm2 = SMAlgorithm.calc(
            quality: event.score,
            repetitions: event.grammarPoint.repetitionsGrammarPoint,
            previousInterval: event.grammarPoint.previousIntervalGrammarPoint,
            previousEaseFactor:
                event.grammarPoint.previousEaseFactorGrammarPoint,
          );
          toUpdate = {
            GrammarTableFields.previousIntervalGrammarPointField: sm2.interval,
            GrammarTableFields.previousIntervalAsDateGrammarPointField:
                sm2.intervalAsDate,
            GrammarTableFields.repetitionsGrammarPointField: sm2.repetitions,
            GrammarTableFields.previousEaseFactorGrammarPointField:
                sm2.easeFactor,
          };
          break;
      }

      await _grammarPointRepository.updateGrammarPoint(
        event.grammarPoint.listName,
        event.grammarPoint.name,
        toUpdate,
      );
      emit(const GrammarModeState.sm2Calculated());
    });

    on<GrammarModeEventUpdateDateShown>((event, emit) async {
      final toUpdate = {
        GrammarTableFields.dateLastShownField: Utils.getCurrentMilliseconds(),
      };

      switch (event.mode) {
        case GrammarModes.definition:
          toUpdate.addEntries([
            MapEntry(GrammarTableFields.dateLastShownDefinitionField,
                Utils.getCurrentMilliseconds())
          ]);
          break;
        case GrammarModes.grammarPoints:
          toUpdate.addEntries([
            MapEntry(GrammarTableFields.dateLastShownGrammarPointField,
                Utils.getCurrentMilliseconds())
          ]);
          break;
      }

      await _grammarPointRepository.updateGrammarPoint(
          event.listName, event.name, toUpdate);
    });

    on<GrammarModeEventUpdateScoreForTestsAffectingPractice>(
        (event, emit) async {
      /// Map for storing the overall scores on each appearing list on the test
      Map<String, double> overallScore = {};
      Map<String, List<GrammarPoint>> orderedMap = {};

      /// Populate the GrammarPoint arrays by their name in the orderedMap. It will look like this:
      /// {
      ///   list2: [],
      ///   list4: [],
      ///   ...,
      ///   listN: [...]
      /// }
      /// The map is only populated with the empty lists that appears on the test.
      for (var point in event.grammarPoints) {
        orderedMap[point.listName] = [];
        overallScore[point.listName] = 0;
      }

      /// For every entry, populate the list with all of the grammar point of each list
      /// that appeared on the test
      for (int x = 0; x < orderedMap.keys.toList().length; x++) {
        String kanListName = orderedMap.keys.toList()[x];
        orderedMap[kanListName] = await _grammarPointRepository
            .getAllGrammarPointsFromList(kanListName);
      }

      /// Calculate the overall score for each list on the treated map
      for (int x = 0; x < orderedMap.keys.toList().length; x++) {
        String kanListName = orderedMap.keys.toList()[x];
        orderedMap[kanListName]?.forEach((p) {
          switch (event.mode) {
            case GrammarModes.definition:
              if (p.winRateDefinition != DatabaseConstants.emptyWinRate) {
                overallScore[kanListName] =
                    (overallScore[kanListName] ?? 0) + p.winRateDefinition;
              }
              break;
            case GrammarModes.grammarPoints:
              if (p.winRateGrammarPoint != DatabaseConstants.emptyWinRate) {
                overallScore[kanListName] =
                    (overallScore[kanListName] ?? 0) + p.winRateGrammarPoint;
              }
              break;
          }
        });

        /// For each list, update its overall rating after getting the overall score
        final double overall =
            overallScore[kanListName]! / orderedMap[kanListName]!.length;

        /// We just need to update the totalWinRate as a reflection of the already
        /// meaned out words in the KanList
        Map<String, dynamic> toUpdate = {};

        switch (event.mode) {
          case GrammarModes.definition:
            toUpdate = {ListTableFields.totalWinRateDefinitionField: overall};
            break;
          case GrammarModes.grammarPoints:
            toUpdate = {ListTableFields.totalWinRateGrammarPointField: overall};
            break;
        }

        await _listRepository.updateList(kanListName, toUpdate);
      }
    });

    on<GrammarModeEventGetScore>((event, emit) async {
      double overallScore = 0;

      /// Get the word from the DB rather than the args instance as the args
      /// instance does not have the updated values
      List<GrammarPoint> points = await _grammarPointRepository
          .getAllGrammarPointsFromList(event.listName);
      for (var p in points) {
        switch (event.mode) {
          case GrammarModes.definition:
            if (p.winRateDefinition != DatabaseConstants.emptyWinRate) {
              overallScore += p.winRateDefinition;
            }
            break;
          case GrammarModes.grammarPoints:
            if (p.winRateGrammarPoint != DatabaseConstants.emptyWinRate) {
              overallScore += p.winRateGrammarPoint;
            }
            break;
        }
      }

      emit(GrammarModeState.scoreObtained(overallScore));
    });

    on<GrammarModeEventUpdateListScore>((event, emit) async {
      Map<String, dynamic> toUpdate = {};

      /// We just need to update the totalWinRate as a reflection of the already
      /// meaned out words in the KanList
      switch (event.mode) {
        case GrammarModes.definition:
          toUpdate = {ListTableFields.totalWinRateDefinitionField: event.score};
          break;
        case GrammarModes.grammarPoints:
          toUpdate = {
            ListTableFields.totalWinRateGrammarPointField: event.score
          };
          break;
      }
      await _listRepository.updateList(event.listName, toUpdate);
    });
  }
}
