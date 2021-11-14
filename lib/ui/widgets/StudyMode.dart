import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';

class TestStudyMode extends StatelessWidget {
  /// List of [Kanji] to make the test with
  final List<Kanji> list;
  /// Chain of lists as a [String] used when creating the [list]
  final String listsNames;
  const TestStudyMode({required this.list, required this.listsNames});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: studyModeWidgetHeight,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: customButtonHeight,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                _modeBasedButtons(context, StudyModes.writing),
                _modeBasedButtons(context, StudyModes.reading),
                _modeBasedButtons(context, StudyModes.recognition)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text("頑張って!!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text("Good Luck!", style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      )
    );
  }

  CustomButton _modeBasedButtons(BuildContext context, StudyModes mode) {
    return CustomButton(
      width: (MediaQuery.of(context).size.width / 3) - 24,
      title1: mode.japMode,
      title2: mode.mode,
      color: mode.color,
      onTap: () async {
        if (list.isEmpty) {
          Navigator.of(context).pop();
          GeneralUtils.getSnackBar(context, "The kanji list selected for the test "
              "is empty. Cannot perform test.");
        }
        else {
          list.shuffle();
          List<Kanji> sortedList = list.sublist(0, list.length < numberOfKanjiInTest
              ? list.length : numberOfKanjiInTest);
          Navigator.of(context).pop(); // Dismiss bottom sheet
          switch (mode) {
            case StudyModes.writing:
              await Navigator.of(context).pushNamed(writingStudyPage,
                  arguments: ModeArguments(studyList: sortedList, isTest: true, mode: mode, listsNames: listsNames));
              break;
            case StudyModes.reading:
              await Navigator.of(context).pushNamed(readingStudyPage,
                  arguments: ModeArguments(studyList: sortedList, isTest: true, mode: mode, listsNames: listsNames));
              break;
            case StudyModes.recognition:
              await Navigator.of(context).pushNamed(recognitionStudyPage,
                  arguments: ModeArguments(studyList: sortedList, isTest: true, mode: mode, listsNames: listsNames));
              break;
          }
        }
      }
    );
  }
}
