import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/presentation/test_result_page/arguments.dart';

/// Handler class to help evade boiler plate code when managing the calculation
/// of scores in every mode
class StudyModeUpdateHandler {
  /// Handles the finish of the test/practice. Please, make sure to view the function
  /// itself to understand it better.
  static Future<bool> handle(
    BuildContext bloc,
    ModeArguments args, {
    bool onPop = false,
    double testScore = 0,
    int lastIndex = 0,
    int timeObtained = 0,
    List<double> testScores = const [],
  }) async {
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
      context: bloc,
      builder: (context) {
        return BlocConsumer<StudyModeBloc, StudyModeState>(
          listener: (context, state) {
            state.mapOrNull(
              scoreObtained: (s) {
                final double score = s.score / args.studyList.length;
                bloc.read<StudyModeBloc>().add(StudyModeEventUpdateListScore(
                    score, args.studyList[0].listName, args.mode));
                Navigator.of(context).pop();
              },
            );
          },
          builder: (context, state) {
            return KPDialog(
                title: Text(isTestFinished || isPracticeFinished
                    ? "study_mode_update_handler_finished_title".tr()
                    : "study_mode_update_handler_popped_title".tr()),
                content: Column(children: [
                  Text(content),
                  const SizedBox(height: KPMargins.margin8),
                  state.mapOrNull(
                          loading: (_) => const SizedBox(
                                width: KPMargins.margin32,
                                height: KPMargins.margin32,
                                child: KPProgressIndicator(),
                              )) ??
                      const SizedBox(),
                ]),
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
                    Map<String, List<Map<Word, double>>>? studyList;

                    /// If the test was a number test, just go to the result page with
                    /// a null study list to not show anything.
                    if (!args.isNumberTest) {
                      bloc.read<StudyModeBloc>().add(
                            StudyModeEventUpdateScoreForTestsAffectingPractice(
                              args.studyList,
                              args.mode,
                              getIt<PreferencesService>()
                                      .readData(SharedKeys.affectOnPractice) ??
                                  false,
                            ),
                          );
                      studyList =
                          _getMapOfWordsInTest(args.studyList, testScores);
                    }
                    // TODO: Added alterTest when adding TEST such as number
                    navigator.pushReplacementNamed(
                        KanPracticePages.testResultPage,
                        arguments: TestResultArguments(
                          score: testScore,
                          word: args.studyList.length,
                          studyMode: args.mode.index,
                          testMode: args.testMode.index,
                          listsName: args.testHistoryDisplasyName,
                          timeObtained: timeObtained,
                          studyList: studyList,
                          alterTest: args.isNumberTest,
                        ));
                  }

                  /// If the user went back in mid list, update the list accordingly
                  else if (isPracticePopped) {
                    /// If I am in the first word, just pop
                    if (lastIndex == 0) {
                      Navigator.of(context).pop();
                    } else {
                      bloc.read<StudyModeBloc>().add(StudyModeEventGetScore(
                          args.studyList[0].listName, args.mode));
                    }
                  }

                  /// If the user went through all the list, update the list accordingly
                  else {
                    bloc.read<StudyModeBloc>().add(StudyModeEventGetScore(
                        args.studyList[0].listName, args.mode));
                  }
                });
          },
        );
      },
    );
    return false;
  }

  static Map<String, List<Map<Word, double>>> _getMapOfWordsInTest(
      List<Word> studyList, List<double> testScores) {
    Map<String, List<Map<Word, double>>> orderedMap = {};
    for (var word in studyList) {
      orderedMap[word.listName] = [];
    }
    for (int x = 0; x < studyList.length; x++) {
      orderedMap[studyList[x].listName]?.add({studyList[x]: testScores[x]});
    }
    return orderedMap;
  }
}
