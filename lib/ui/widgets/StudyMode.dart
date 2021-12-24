import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
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
          Container(
            height: CustomSizes.defaultSizeStudyModeSelection,
            padding: EdgeInsets.symmetric(horizontal: Margins.margin32),
            child: GridView.builder(
              itemCount: StudyModes.values.length,
              physics: NeverScrollableScrollPhysics(),
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
    return Expanded(
      child: CustomButton(
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
            List<Kanji> sortedList = list.sublist(0, list.length < CustomSizes.numberOfKanjiInTest
                ? list.length : CustomSizes.numberOfKanjiInTest);
            Navigator.of(context).pop(); // Dismiss bottom sheet
            switch (mode) {
              case StudyModes.writing:
                await Navigator.of(context).pushNamed(KanPracticePages.writingStudyPage,
                    arguments: ModeArguments(studyList: sortedList, isTest: true, mode: mode, listsNames: listsNames));
                break;
              case StudyModes.reading:
                await Navigator.of(context).pushNamed(KanPracticePages.readingStudyPage,
                    arguments: ModeArguments(studyList: sortedList, isTest: true, mode: mode, listsNames: listsNames));
                break;
              case StudyModes.recognition:
                await Navigator.of(context).pushNamed(KanPracticePages.recognitionStudyPage,
                    arguments: ModeArguments(studyList: sortedList, isTest: true, mode: mode, listsNames: listsNames));
                break;
              case StudyModes.listening:
                /// TODO: Navigate to listening study page
                break;
            }
          }
        }
      ),
    );
  }
}
