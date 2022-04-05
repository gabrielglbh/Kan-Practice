import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:easy_localization/easy_localization.dart';

class TestStudyMode extends StatelessWidget {
  /// List of [Kanji] to make the test with.
  ///
  /// If [list] is null, the list must be loaded upon the mode selection (BLITZ or REMEMBRANCE).
  ///
  /// If it is not null, the list must come from (SELECTION TEST).
  final List<Kanji>? list;
  /// Chain of lists as a [String] used when creating the [list]
  final String listsNames;
  /// ONLY VALID FOR BLITZ OR REMEMBRANCE TESTS.
  ///
  /// String defining if the user wants to perform a Blitz Test on a practice
  /// lesson specifically. If null, all kanji available will be taken into consideration.
  final String? practiceList;
  /// ONLY VALID FOR BLITZ OR REMEMBRANCE TESTS OR LESS % TESTS.
  final bool remembranceTest;
  final bool lessPctTest;
  const TestStudyMode({this.list, this.practiceList, this.remembranceTest = false,
    required this.listsNames, this.lessPctTest = false});

  Future<List<Kanji>> _loadBlitzTest(StudyModes mode) async {
    String? listName = practiceList;
    /// Get all the list of all kanji and perform a 20 kanji random sublist
    if (listName == null) {
      List<Kanji> list = await KanjiQueries.instance.getAllKanji(mode: mode,
          orderedByLastShown: remembranceTest, orderedByWorstAccuracy: lessPctTest);
      /// If it is a remembrance or less % test, do NOT shuffle the list
      if (!remembranceTest && !lessPctTest) list.shuffle();
      return list;
    }
    /// If the listName is not empty, it means that the user wants to have
    /// a Blitz Test on a certain KanList defined in "listName"
    else {
      List<Kanji> list = await KanjiQueries.instance.getAllKanjiFromList(listName);
      list.shuffle();
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Visibility(
            visible: StorageManager.readData(StorageManager.affectOnPractice) == true,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Margins.margin16),
                    child: Icon(Icons.auto_graph_rounded, color: Colors.lightBlueAccent),
                  ),
                  Expanded(
                    child: Text("settings_general_toggle".tr(), textAlign: TextAlign.center)
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Margins.margin16),
                    child: Icon(Icons.auto_graph_rounded, color: Colors.lightBlueAccent),
                  ),
                ],
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: GridView.builder(
              itemCount: StudyModes.values.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.9
              ),
              itemBuilder: (context, index) {
                switch (StudyModes.values[index]) {
                  case StudyModes.writing:
                    return _modeBasedButtons(context, StudyModes.writing);
                  case StudyModes.reading:
                    return _modeBasedButtons(context, StudyModes.reading);
                  case StudyModes.recognition:
                    return _modeBasedButtons(context, StudyModes.recognition);
                  case StudyModes.listening:
                    return _modeBasedButtons(context, StudyModes.listening);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Margins.margin16, bottom: Margins.margin16),
            child: Text("study_modes_good_luck".tr(),
                style: TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
          )
        ],
      )
    );
  }

  Widget _modeBasedButtons(BuildContext context, StudyModes mode) {
    return CustomButton(
      title1: mode.japMode,
      title2: mode.mode,
      color: mode.color,
      onTap: () async {
        List<Kanji>? l = list;
        if (l != null) {
          if (l.isEmpty) {
            Navigator.of(context).pop();
            GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
          } else {
            await _decideOnMode(context, l, mode);
          }
        } else {
          List<Kanji> l = await _loadBlitzTest(mode);
          if (l.isEmpty) {
            Navigator.of(context).pop();
            GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
          } else await _decideOnMode(context, l, mode);
        }
      }
    );
  }

  Future<void> _decideOnMode(BuildContext context, List<Kanji> l, StudyModes mode) async {
    String displayTestName = remembranceTest ? "test_mode_remembrance".tr()
        : lessPctTest ? "test_mode_less".tr()
        : list != null ? "test_mode_selection".tr()
        : "test_mode_blitz".tr();

    List<Kanji> sortedList = l.sublist(0, l.length < CustomSizes.numberOfKanjiInTest
        ? l.length : CustomSizes.numberOfKanjiInTest);
    Navigator.of(context).pop(); // Dismiss bottom sheet

    switch (mode) {
      case StudyModes.writing:
        await Navigator.of(context).pushNamed(KanPracticePages.writingStudyPage,
            arguments: ModeArguments(studyList: sortedList, isTest: true,
                display: displayTestName, mode: mode, listsNames: listsNames));
        break;
      case StudyModes.reading:
        await Navigator.of(context).pushNamed(KanPracticePages.readingStudyPage,
            arguments: ModeArguments(studyList: sortedList, isTest: true,
                display: displayTestName, mode: mode, listsNames: listsNames));
        break;
      case StudyModes.recognition:
        await Navigator.of(context).pushNamed(KanPracticePages.recognitionStudyPage,
            arguments: ModeArguments(studyList: sortedList, isTest: true,
                display: displayTestName, mode: mode, listsNames: listsNames));
        break;
      case StudyModes.listening:
        await Navigator.of(context).pushNamed(KanPracticePages.listeningStudyPage,
            arguments: ModeArguments(studyList: sortedList, isTest: true,
                display: displayTestName, mode: mode, listsNames: listsNames));
        break;
    }
  }
}
