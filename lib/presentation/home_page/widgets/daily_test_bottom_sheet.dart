import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class DailyBottomSheet extends StatelessWidget {
  final String? folder;
  const DailyBottomSheet({Key? key, this.folder}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context, {String? folder}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DailyBottomSheet(folder: folder));
  }

  Future<void> _loadDailyTest(BuildContext context) async {
    final navigator = Navigator.of(context);
    final randomStudyMode =
        StudyModes.values[Random().nextInt(StudyModes.values.length)];
    final kanjiInTest =
        StorageManager.readData(StorageManager.numberOfKanjiInTest) ??
            KPSizes.numberOfKanjiInTest;

    final today = await Utils.parseTodayDate(context);
    List<Kanji> list = [];
    if (folder == null) {
      list = await KanjiQueries.instance.getDailyKanjis(randomStudyMode);
    } else {
      list = await FolderQueries.instance.getAllKanjiOnListsOnFolder(
        [folder!],
        type: Tests.daily,
        mode: randomStudyMode,
      );
    }
    List<Kanji> sortedList =
        list.sublist(0, list.length < kanjiInTest ? list.length : kanjiInTest);

    navigator.pop(); // Dismiss this bottom sheet
    navigator.pop(); // Dismiss the tests bottom sheet

    final folderTitle = folder != null ? " - $folder" : "";
    final name = "${"abbr_test_mode_daily".tr()}: $today$folderTitle";

    /// Save to SharedPreferences the current folder, if any, to manage
    /// proper navigation when finishing the test.
    /// See addPostFrameCallback() in init() in [HomePage]
    StorageManager.saveData(StorageManager.folderWhenOnTest, folder ?? "");
    await navigator.pushNamed(
      randomStudyMode.page,
      arguments: ModeArguments(
        studyList: sortedList,
        isTest: true,
        testMode: Tests.daily,
        studyModeHeaderDisplayName: Tests.daily.name,
        mode: randomStudyMode,
        testHistoryDisplasyName: name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = folder != null ? ": $folder" : "";
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
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("${"daily_test_bottom_sheet_title".tr()}$title",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Visibility(
                visible:
                    StorageManager.readData(StorageManager.affectOnPractice) ==
                        true,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: KPMargins.margin8,
                      horizontal: KPMargins.margin24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: KPMargins.margin16),
                        child: Icon(Icons.auto_graph_rounded,
                            color: Colors.lightBlueAccent),
                      ),
                      Expanded(
                          child: Text(
                        "settings_general_toggle".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                      const Padding(
                        padding: EdgeInsets.only(left: KPMargins.margin16),
                        child: Icon(Icons.auto_graph_rounded,
                            color: Colors.lightBlueAccent),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("daily_test_description".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              KPButton(
                title1: "daily_test_start_button_tr".tr(),
                title2: "daily_test_start_button".tr(),
                onTap: () async {
                  await _loadDailyTest(context);
                },
              ),
            ],
          ),
        ]);
      },
    );
  }
}
