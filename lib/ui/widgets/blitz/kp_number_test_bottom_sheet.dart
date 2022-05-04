import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/number_ranges.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:easy_localization/easy_localization.dart';

class KPNumberTestBottomSheet extends StatefulWidget {
  const KPNumberTestBottomSheet({Key? key}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const KPNumberTestBottomSheet()
    );
  }

  @override
  _KPNumberTestBottomSheetState createState() => _KPNumberTestBottomSheetState();
}

class _KPNumberTestBottomSheetState extends State<KPNumberTestBottomSheet> {
  final List<Ranges> _selectedLists = [];

  List<Kanji> _loadBlitzTest() {
    /// If no range is selected, 0 to 10K will be taken
    int min = Ranges.from0to1K.min;
    int max = Ranges.from1Kto10K.max;
    final _random = Random();

    /// Sort the list of selected ranges to properly apply the min and max
    _selectedLists.sort((a, b) => a.index.compareTo(b.index));
    if (_selectedLists.isNotEmpty) {
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
                const KPDragContainer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("number_bottom_sheet_title".tr(), textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("${CustomSizes.numberOfKanjiInTest.toString()} "
                    "${"number_bottom_sheet_content".tr()}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 4.5
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Ranges.values.length,
                  itemBuilder: (context, index) {
                    Ranges range = Ranges.values[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: Margins.margin8),
                      child: ActionChip(
                          label: Text(range.label),
                          pressElevation: Margins.margin4,
                          backgroundColor: _selectedLists.contains(range)
                              ? CustomColors.secondaryDarkerColor : CustomColors.secondaryColor,
                          onPressed: () {
                            setState(() {
                              if (_selectedLists.contains(range)) {
                                _selectedLists.remove(range);
                              } else {
                                _selectedLists.add(range);
                              }
                            });
                          }
                      ),
                    );
                  },
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
        KPButton(
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
                  mode: StudyModes.listening,
                  testMode: Tests.numbers,
                  display: "test_mode_number".tr(),
                  listsNames: listsNames, isNumberTest: true));
            }
          }
        ),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin16, bottom: Margins.margin16),
          child: Text("study_modes_good_luck".tr(),
              style: Theme.of(context).textTheme.headline5),
        )
      ],
    );
  }
}