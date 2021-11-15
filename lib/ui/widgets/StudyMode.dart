import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:easy_localization/easy_localization.dart';

class TestStudyMode extends StatelessWidget {
  /// List of [Kanji] to make the test with
  final List<Kanji> list;
  /// Chain of lists as a [String] used when creating the [list]
  final String listsNames;
  const TestStudyMode({required this.list, required this.listsNames});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Text("study_modes_good_luck".tr(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
          GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
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
