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

enum Ranges { from0to1K, from1Kto10K, from10Kto100K, from100Kto1M }

extension RangesExt on Ranges {
  String get label {
    switch (this) {
      case Ranges.from0to1K:
        return "0 - 1.000";
      case Ranges.from1Kto10K:
        return "1.000 - 10.000";
      case Ranges.from10Kto100K:
        return "10.000 - 100.000";
      case Ranges.from100Kto1M:
        return "100.000 - 1.000.000";
    }
  }

  int get min {
    switch (this) {
      case Ranges.from0to1K:
        return 0;
      case Ranges.from1Kto10K:
        return 1000;
      case Ranges.from10Kto100K:
        return 10000;
      case Ranges.from100Kto1M:
        return 100000;
    }
  }

  int get max {
    switch (this) {
      case Ranges.from0to1K:
        return 1000;
      case Ranges.from1Kto10K:
        return 10000;
      case Ranges.from10Kto100K:
        return 100000;
      case Ranges.from100Kto1M:
        return 1000000;
    }
  }
}

class NumberTestBottomSheet extends StatefulWidget {
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

  @override
  _NumberTestBottomSheetState createState() => _NumberTestBottomSheetState();
}

class _NumberTestBottomSheetState extends State<NumberTestBottomSheet> {
  List<Ranges> _selectedLists = [];

  List<Kanji> _loadBlitzTest() {
    /// If no range is selected, 0 to 10K will be taken
    int min = Ranges.from0to1K.min;
    int max = Ranges.from1Kto10K.max;
    final _random = Random();

    /// Sort the list of selected ranges to properly apply the min and max
    _selectedLists.sort((a, b) => a.index.compareTo(b.index));
    if (_selectedLists.length > 0) {
      min = _selectedLists[0].min;
      max = _selectedLists[_selectedLists.length - 1].max;
    }

    return List.generate(CustomSizes.numberOfKanjiInTest, (n) {
      String num = (min + _random.nextInt((max + 1) - min)).toString();
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
                Container(
                  height: CustomSizes.defaultSizeRangesHeight,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 4.5
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Ranges.values.length,
                    itemBuilder: (context, index) {
                      Ranges range = Ranges.values[index];
                      return Padding(
                        padding: EdgeInsets.only(right: Margins.margin8),
                        child: ActionChip(
                            label: Text(range.label),
                            pressElevation: Margins.margin4,
                            backgroundColor: _selectedLists.contains(range)
                                ? CustomColors.secondaryDarkerColor : CustomColors.secondaryColor,
                            onPressed: () {
                              setState(() {
                                if (_selectedLists.contains(range)) _selectedLists.remove(range);
                                else _selectedLists.add(range);
                              });
                            }
                        ),
                      );
                    },
                  ),
                ),
                _numberButton(context, "number_bottom_sheet_label".tr())
              ],
            ),
          ]
        );
      },
    );
  }

  Widget _numberButton(BuildContext context, String listsNames) {
    return Column(
      children: [
        CustomButton(
          title1: "number_bottom_sheet_begin_ext".tr(),
          title2: "number_bottom_sheet_begin".tr(),
          width: true,
          onTap: () async {
            List<Kanji> list = _loadBlitzTest();
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