import 'package:flutter/material.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/widgets/StudyMode.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';

class BlitzBottomSheet extends StatelessWidget {
  /// String defining if the user wants to perform a Blitz Test on a practice
  /// lesson specifically. If null, all kanji available will be taken into consideration.
  final String? practiceList;
  final bool remembranceTest;
  final bool lessPctTest;
  /// Creates a blitz test study mode selection bottom sheet for BLITZ and
  /// REMEMBRANCE tests.
  const BlitzBottomSheet({this.practiceList, this.remembranceTest = false, this.lessPctTest = false});

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> show(BuildContext context,
      {String? practiceList, bool remembranceTest = false, bool lessPctTest = false}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlitzBottomSheet(
        practiceList: practiceList, remembranceTest: remembranceTest, lessPctTest: lessPctTest
      )
    );
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
                      : lessPctTest
                      ? "less_pct_bottom_sheet_title".tr()
                      : "blitz_bottom_sheet_title".tr(), textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("${CustomSizes.numberOfKanjiInTest.toString()} ${
                      remembranceTest
                          ? "remembrance_bottom_sheet_content".tr()
                          : lessPctTest
                          ? "less_pct_bottom_sheet_content".tr()
                          : "blitz_bottom_sheet_content".tr()
                  }",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize16)),
                ),
                TestStudyMode(
                  practiceList: practiceList,
                  remembranceTest: remembranceTest,
                  lessPctTest: lessPctTest,
                  listsNames: remembranceTest ? "remembrance_bottom_sheet_label".tr()
                      : lessPctTest ? "less_pct_bottom_sheet_label".tr()
                      : practiceList == null ? 'blitz_bottom_sheet_label'.tr()
                      : '${"blitz_bottom_sheet_on_label".tr()} $practiceList',
                )
              ],
            ),
          ]
        );
      },
    );
  }
}