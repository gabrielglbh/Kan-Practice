import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/widgets/kp_study_mode.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:easy_localization/easy_localization.dart';

class KPBlitzBottomSheet extends StatelessWidget {
  /// String defining if the user wants to perform a Blitz Test on a practice
  /// lesson specifically. If null, all kanji available will be taken into consideration.
  final String? practiceList;

  /// Folder for UI on history test
  final String? folder;
  final bool remembranceTest;
  final bool lessPctTest;

  /// Creates a blitz test study mode selection bottom sheet for BLITZ and
  /// REMEMBRANCE tests.
  const KPBlitzBottomSheet({
    Key? key,
    this.practiceList,
    this.folder,
    this.remembranceTest = false,
    this.lessPctTest = false,
  }) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> show(
    BuildContext context, {
    String? practiceList,
    String? folder,
    bool remembranceTest = false,
    bool lessPctTest = false,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KPBlitzBottomSheet(
        practiceList: practiceList,
        folder: folder,
        remembranceTest: remembranceTest,
        lessPctTest: lessPctTest,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = remembranceTest
        ? "remembrance_bottom_sheet_title".tr()
        : lessPctTest
            ? "less_pct_bottom_sheet_title".tr()
            : "blitz_bottom_sheet_title".tr();
    final folderTitle = folder != null ? ": $folder" : "";
    final kanjiInTest =
        StorageManager.readData(StorageManager.numberOfKanjiInTest) ??
            CustomSizes.numberOfKanjiInTest;
    final type = remembranceTest
        ? Tests.time
        : lessPctTest
            ? Tests.less
            : folder != null
                ? Tests.folder
                : Tests.blitz;

    final description = remembranceTest
        ? "remembrance_bottom_sheet_content".tr()
        : lessPctTest
            ? "less_pct_bottom_sheet_content".tr()
            : "blitz_bottom_sheet_content".tr();

    String testName = "";
    if (remembranceTest) {
      if (folder == null) {
        testName = "remembrance_bottom_sheet_label".tr();
      } else {
        testName = '${"remembrance_bottom_sheet_on_folder_label".tr()} $folder';
      }
    } else if (lessPctTest) {
      if (folder == null) {
        testName = "less_pct_bottom_sheet_label".tr();
      } else {
        testName = '${"less_pct_bottom_sheet_on_folder_label".tr()} $folder';
      }
    } else if (folder != null) {
      testName = '${"blitz_bottom_sheet_on_folder_label".tr()} $folder';
    } else if (practiceList == null) {
      testName = 'blitz_bottom_sheet_label'.tr();
    } else {
      testName = '${"blitz_bottom_sheet_on_label".tr()} $practiceList';
    }

    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Margins.margin8, horizontal: Margins.margin32),
                child: Text("$title$folderTitle",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Margins.margin8, horizontal: Margins.margin32),
                child: Text("$kanjiInTest $description",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              KPTestStudyMode(
                practiceList: practiceList,
                folder: folder,
                type: type,
                testName: testName,
              )
            ],
          ),
        ]);
      },
    );
  }
}
