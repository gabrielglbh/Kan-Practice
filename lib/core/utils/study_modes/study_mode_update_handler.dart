import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

/// Handler class to help evade boiler plate code when managing the calculation
/// of scores in every mode
class StudyModeUpdateHandler {
  /// Handles the finish of the test/practice. Please, make sure to view the function
  /// itself to understand it better.
  static Future<bool> handle(BuildContext context, ModeArguments args,
      {bool onPop = false,
      double testScore = 0,
      int lastIndex = 0,
      List<double> testScores = const []}) async {
    bool isTestFinished = !onPop && args.isTest;
    bool isTestPopped = onPop && args.isTest;
    bool isPracticePopped = onPop && !args.isTest;
    bool isPracticeFinished = !onPop && !args.isTest;

    String content = "";
    if (isTestPopped) {
      content = "study_mode_update_handler_poppedTest_content".tr();
    } else if (isTestFinished) {
      content = "study_mode_update_handler_finishedTest_content".tr();
    } else if (isPracticePopped) {
      content = "study_mode_update_handler_poppedPractice_content".tr();
    } else {
      content = "study_mode_update_handler_finishedPractice_content".tr();
    }

    showDialog(
        context: context,
        builder: (context) {
          return KPDialog(
              title: Text(isTestFinished || isPracticeFinished
                  ? "study_mode_update_handler_finished_title".tr()
                  : "study_mode_update_handler_popped_title".tr()),
              content: Text(content),
              positiveButtonText: isTestFinished || isPracticeFinished
                  ? "study_mode_update_handler_finished_positive".tr()
                  : "study_mode_update_handler_popped_positive".tr(),
              popDialog: !isTestFinished,
              onPositive: () async {
                /// If user went back in mid test, just pop
                if (isTestPopped) {
                  Navigator.of(context).pop();
                } else if (isTestFinished) {
                  final navigator = Navigator.of(context);
                  Map<String, List<Map<Kanji, double>>>? studyList;

                  /// If the test was a number test, just go to the result page with
                  /// a null study list to not show anything.
                  if (!args.isNumberTest) {
                    if (StorageManager.readData(
                            StorageManager.affectOnPractice) ??
                        false) {
                      await _updateScoreForTestsAffectingPractice(args);
                    }
                    studyList =
                        _getMapOfKanjiInTest(args.studyList, testScores);
                  }
                  navigator.pushReplacementNamed(
                      KanPracticePages.testResultPage,
                      arguments: TestResultArguments(
                          score: testScore,
                          kanji: args.studyList.length,
                          studyMode: args.mode.index,
                          testMode: args.testMode.index,
                          listsName: args.listsNames,
                          studyList: studyList));
                }

                /// If the user went back in mid list, update the list accordingly
                /// keeping in mind that the score of the last kanji should be 0.5.
                else if (isPracticePopped) {
                  /// If I am in the first kanji, just pop, no need to penalize
                  if (lastIndex == 0) {
                    Navigator.of(context).pop();
                  } else {
                    final navigator = Navigator.of(context);
                    await calculateScore(args, 0.5, lastIndex);
                    final double score =
                        await _getScore(args) / args.studyList.length;
                    await _updateList(score, args);
                    navigator.pop();
                  }
                }

                /// If the user went through all the list, update the list accordingly
                else {
                  final navigator = Navigator.of(context);
                  final double score =
                      await _getScore(args) / args.studyList.length;
                  await _updateList(score, args);
                  navigator.pop();
                }
              });
        });
    return false;
  }

  /// Calculates the score of a given kanji in the position [index] of the list
  /// and rates its overall score, and updates it on the db.
  static Future<int> calculateScore(
      ModeArguments args, double score, int index) async {
    double actualScore = 0;
    Map<String, dynamic> toUpdate = {};

    /// If winRate of any mode is -1, it means that the user has not studied this
    /// kanji yet. Therefore, the score should be untouched.
    /// If the winRate is different than -1, the user has already studied this kanji
    /// and then, a mean is calculated between the upcoming score and the previous one.
    switch (args.mode) {
      case StudyModes.writing:
        if (args.studyList[index].winRateWriting ==
            DatabaseConstants.emptyWinRate) {
          actualScore = score;
        } else {
          actualScore = (score + args.studyList[index].winRateWriting) / 2;
        }
        toUpdate = {KanjiTableFields.winRateWritingField: actualScore};
        break;
      case StudyModes.reading:
        if (args.studyList[index].winRateReading ==
            DatabaseConstants.emptyWinRate) {
          actualScore = score;
        } else {
          actualScore = (score + args.studyList[index].winRateReading) / 2;
        }
        toUpdate = {KanjiTableFields.winRateReadingField: actualScore};
        break;
      case StudyModes.recognition:
        if (args.studyList[index].winRateRecognition ==
            DatabaseConstants.emptyWinRate) {
          actualScore = score;
        } else {
          actualScore = (score + args.studyList[index].winRateRecognition) / 2;
        }
        toUpdate = {KanjiTableFields.winRateRecognitionField: actualScore};
        break;
      case StudyModes.listening:
        if (args.studyList[index].winRateListening ==
            DatabaseConstants.emptyWinRate) {
          actualScore = score;
        } else {
          actualScore = (score + args.studyList[index].winRateListening) / 2;
        }
        toUpdate = {KanjiTableFields.winRateListeningField: actualScore};
        break;
    }
    return await KanjiQueries.instance.updateKanji(
        args.studyList[index].listName, args.studyList[index].kanji, toUpdate);
  }

  static Map<String, List<Map<Kanji, double>>> _getMapOfKanjiInTest(
      List<Kanji> studyList, List<double> testScores) {
    Map<String, List<Map<Kanji, double>>> orderedMap = {};
    for (var kanji in studyList) {
      orderedMap[kanji.listName] = [];
    }
    for (int x = 0; x < studyList.length; x++) {
      orderedMap[studyList[x].listName]?.add({studyList[x]: testScores[x]});
    }
    return orderedMap;
  }

  static Future<void> _updateScoreForTestsAffectingPractice(
      ModeArguments args) async {
    /// Map for storing the overall scores on each appearing list on the test
    Map<String, double> overallScore = {};
    Map<String, List<Kanji>> orderedMap = {};

    /// Populate the Kanji arrays by their name in the orderedMap. It will look like this:
    /// {
    ///   list2: [],
    ///   list4: [],
    ///   ...,
    ///   listN: [...]
    /// }
    /// The map is only populated with the empty lists that appears on the test.
    for (var kanji in args.studyList) {
      orderedMap[kanji.listName] = [];
      overallScore[kanji.listName] = 0;
    }

    /// For every entry, populate the list with all of the kanji of each list
    /// that appeared on the test
    for (int x = 0; x < orderedMap.keys.toList().length; x++) {
      String kanListName = orderedMap.keys.toList()[x];
      orderedMap[kanListName] =
          await KanjiQueries.instance.getAllKanjiFromList(kanListName);
    }

    /// Calculate the overall score for each list on the treated map
    for (int x = 0; x < orderedMap.keys.toList().length; x++) {
      String kanListName = orderedMap.keys.toList()[x];
      orderedMap[kanListName]?.forEach((k) {
        switch (args.mode) {
          case StudyModes.writing:
            if (k.winRateWriting != DatabaseConstants.emptyWinRate) {
              overallScore[kanListName] =
                  (overallScore[kanListName] ?? 0) + k.winRateWriting;
            }
            break;
          case StudyModes.reading:
            if (k.winRateReading != DatabaseConstants.emptyWinRate) {
              overallScore[kanListName] =
                  (overallScore[kanListName] ?? 0) + k.winRateReading;
            }
            break;
          case StudyModes.recognition:
            if (k.winRateRecognition != DatabaseConstants.emptyWinRate) {
              overallScore[kanListName] =
                  (overallScore[kanListName] ?? 0) + k.winRateRecognition;
            }
            break;
          case StudyModes.listening:
            if (k.winRateListening != DatabaseConstants.emptyWinRate) {
              overallScore[kanListName] =
                  (overallScore[kanListName] ?? 0) + k.winRateListening;
            }
            break;
        }
      });

      /// For each list, update its overall rating after getting the overall score
      final double overall =
          overallScore[kanListName]! / orderedMap[kanListName]!.length;
      await _updateList(overall, args, kanListName: kanListName);
    }
  }

  static Future<double> _getScore(ModeArguments args) async {
    double overallScore = 0;

    /// Get the kanji from the DB rather than the args instance as the args
    /// instance does not have the updated values
    List<Kanji> kanji = await KanjiQueries.instance
        .getAllKanjiFromList(args.studyList[0].listName);
    for (var k in kanji) {
      switch (args.mode) {
        case StudyModes.writing:
          if (k.winRateWriting != DatabaseConstants.emptyWinRate) {
            overallScore += k.winRateWriting;
          }
          break;
        case StudyModes.reading:
          if (k.winRateReading != DatabaseConstants.emptyWinRate) {
            overallScore += k.winRateReading;
          }
          break;
        case StudyModes.recognition:
          if (k.winRateRecognition != DatabaseConstants.emptyWinRate) {
            overallScore += k.winRateRecognition;
          }
          break;
        case StudyModes.listening:
          if (k.winRateListening != DatabaseConstants.emptyWinRate) {
            overallScore += k.winRateListening;
          }
          break;
      }
    }
    return overallScore;
  }

  static Future<void> _updateList(double overall, ModeArguments args,
      {String? kanListName}) async {
    Map<String, dynamic> toUpdate = {};

    /// We just need to update the totalWinRate as a reflection of the already
    /// meaned out words in the KanList
    switch (args.mode) {
      case StudyModes.writing:
        toUpdate = {KanListTableFields.totalWinRateWritingField: overall};
        break;
      case StudyModes.reading:
        toUpdate = {KanListTableFields.totalWinRateReadingField: overall};
        break;
      case StudyModes.recognition:
        toUpdate = {KanListTableFields.totalWinRateRecognitionField: overall};
        break;
      case StudyModes.listening:
        toUpdate = {KanListTableFields.totalWinRateListeningField: overall};
        break;
    }
    await ListQueries.instance
        .updateList(kanListName ?? args.studyList[0].listName, toUpdate);
  }
}
