import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/widgets/StudyMode.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';

class BlitzBottomSheet extends StatelessWidget {
  /// String defining if the user wants to perform a Blitz Test on a practice
  /// lesson specifically. If null, all kanji available will be taken into consideration.
  final String? practiceList;
  final bool remembranceTest;
  final bool numberTest;
  const BlitzBottomSheet({this.practiceList, this.remembranceTest = false, this.numberTest = false});

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> callBlitzModeBottomSheet(BuildContext context,
      {String? practiceList, bool remembranceTest = false, bool numberTest = false}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlitzBottomSheet(
        practiceList: practiceList, remembranceTest: remembranceTest, numberTest: numberTest
      )
    );
  }

  Future<List<Kanji>> _loadBlitzTest() async {
    String? listName = practiceList;
    /// Get all the list of all kanji and perform a 20 kanji random sublist
    if (listName == null) {
      if (remembranceTest) {
        List<Kanji> list = await KanjiQueries.instance.getAllKanji(orderedByLastShown: remembranceTest);
        return list.sublist(0, list.length < CustomSizes.numberOfKanjiInTest
            ? list.length : CustomSizes.numberOfKanjiInTest);
      }
      else if (numberTest) {
        final _random = Random();
        return List.generate(CustomSizes.numberOfKanjiInTest, (n) {
          String num = _random.nextInt(10000001).toString();
          return Kanji(kanji: num, pronunciation: num, meaning: num, listName: "Numbers");
        });
      }
      else {
        List<Kanji> list = await KanjiQueries.instance.getAllKanji(orderedByLastShown: remembranceTest);
        list.shuffle();
        return list.sublist(0, list.length < CustomSizes.numberOfKanjiInTest
            ? list.length : CustomSizes.numberOfKanjiInTest);
      }
    }
    /// If the listName is not empty, it means that the user wants to have
    /// a Blitz Test on a certain KanList defined in "listName"
    else {
      List<Kanji> list = await KanjiQueries.instance.getAllKanjiFromList(listName);
      list.shuffle();
      return list.sublist(0, list.length < CustomSizes.numberOfKanjiInTest
          ? list.length : CustomSizes.numberOfKanjiInTest);
    }
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
                  child: Text(remembranceTest
                      ? "remembrance_bottom_sheet_title".tr()
                      : numberTest
                      ? "number_bottom_sheet_title".tr()
                      : "blitz_bottom_sheet_title".tr(), textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("${CustomSizes.numberOfKanjiInTest.toString()} ${
                      remembranceTest
                          ? "remembrance_bottom_sheet_content".tr()
                          : numberTest
                          ? "number_bottom_sheet_content".tr()
                          : "blitz_bottom_sheet_content".tr()
                  }",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize16)),
                ),
                FutureBuilder<List<Kanji>>(
                  future: _loadBlitzTest(),
                  builder: (context, snapshot) {
                    if (numberTest) {
                      return _numberButton(context, (snapshot.data ?? []),
                          "number_bottom_sheet_label".tr());
                    } else {
                      return TestStudyMode(
                        listsNames: remembranceTest ? "remembrance_bottom_sheet_label".tr()
                            : practiceList == null ? 'blitz_bottom_sheet_label'.tr()
                            : '${"blitz_bottom_sheet_on_label".tr()} $practiceList',
                        list: (snapshot.data ?? []),
                      );
                    }
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
          width: MediaQuery.of(context).size.width / 4,
          onTap: () async {
            if (list.isEmpty) {
              Navigator.of(context).pop();
              GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
            }
            else {
              Navigator.of(context).pop(); // Dismiss bottom sheet
              await Navigator.of(context).pushNamed(KanPracticePages.listeningStudyPage,
                arguments: ModeArguments(studyList: list, isTest: true,
                mode: StudyModes.listening, listsNames: listsNames, isNumberTest: numberTest));
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