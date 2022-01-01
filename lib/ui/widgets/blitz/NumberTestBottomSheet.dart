import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';

class NumberTestBottomSheet extends StatelessWidget {
  const NumberTestBottomSheet();

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => NumberTestBottomSheet()
    );
  }

  Future<List<Kanji>> _loadBlitzTest() async {
    final _random = Random();
    return List.generate(CustomSizes.numberOfKanjiInTest, (n) {
      String num = _random.nextInt(10000001).toString();
      return Kanji(kanji: num, pronunciation: num, meaning: num, listName: "Numbers");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DragContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("number_bottom_sheet_title".tr(), textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("${CustomSizes.numberOfKanjiInTest.toString()} "
                    "${"number_bottom_sheet_content".tr()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize16)),
                ),
                FutureBuilder<List<Kanji>>(
                  future: _loadBlitzTest(),
                  builder: (context, snapshot) {
                    return _numberButton(context, (snapshot.data ?? []),
                        "number_bottom_sheet_label".tr());
                  },
                )
              ],
            ),
          ]
        );
      },
    );
  }

  Widget _numberButton(BuildContext context, List<Kanji> list, String listsNames) {
    return Column(
      children: [
        CustomButton(
          title1: "number_bottom_sheet_begin_ext".tr(),
          title2: "number_bottom_sheet_begin".tr(),
          width: true,
          onTap: () async {
            if (list.isEmpty) {
              Navigator.of(context).pop();
              GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
            }
            else {
              Navigator.of(context).pop(); // Dismiss bottom sheet
              await Navigator.of(context).pushNamed(KanPracticePages.listeningStudyPage,
                arguments: ModeArguments(studyList: list, isTest: true,
                mode: StudyModes.listening, listsNames: listsNames, isNumberTest: true));
            }
          }
        ),
        Padding(
          padding: EdgeInsets.only(top: Margins.margin16, bottom: Margins.margin16),
          child: Text("study_modes_good_luck".tr(),
              style: TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}