import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:easy_localization/easy_localization.dart';

class KPTestStudyMode extends StatelessWidget {
  /// List of [Kanji] to make the test with.
  ///
  /// If [list] is null, the list must be loaded upon the mode selection (BLITZ or REMEMBRANCE or LESS %).
  ///
  /// If it is not null, the list must come from (SELECTION OR CATEGORY TEST).
  final List<Kanji>? list;

  /// Name of the test being performed
  final String testName;

  /// ONLY VALID FOR BLITZ OR REMEMBRANCE TESTS.
  ///
  /// String defining if the user wants to perform a Blitz Test on a practice
  /// lesson specifically. If null, all kanji available will be taken into consideration.
  final String? practiceList;

  /// ONLY VALID FOR FOLDER TEST
  ///
  /// String defining the folder from which gather the words
  final String? folder;

  /// Type of test being performed
  final Tests type;

  const KPTestStudyMode(
      {Key? key,
      this.list,
      this.practiceList,
      this.folder,
      required this.type,
      required this.testName})
      : super(key: key);

  Future<List<Kanji>> _loadTest(StudyModes mode) async {
    String? listName = practiceList;

    /// Get all the list of all kanji and perform a 20 kanji random sublist
    if (listName == null) {
      /// If the type is Folder or Blitz with a specified folder, gather all
      /// words within the folder
      if (type == Tests.folder || (type == Tests.blitz && folder != null)) {
        if (folder == null) return [];

        List<Kanji> list =
            await FolderQueries.instance.getAllKanjiOnListsOnFolder([folder!]);
        list.shuffle();
        return list;
      }
      if ((type == Tests.time || type == Tests.less) && folder != null) {
        List<Kanji> list =
            await FolderQueries.instance.getAllKanjiOnListsOnFolder(
          [folder!],
          mode: mode,
          type: type,
        );
        return list;
      }

      /// Else, just get all Kanji
      List<Kanji> list =
          await KanjiQueries.instance.getAllKanji(mode: mode, type: type);

      /// If it is a remembrance or less % test, do NOT shuffle the list
      if (type != Tests.time && type != Tests.less) list.shuffle();
      return list;
    }

    /// If the listName is not empty, it means that the user wants to have
    /// a Blitz Test on a certain KanList defined in "listName"
    else {
      List<Kanji> list =
          await KanjiQueries.instance.getAllKanjiFromList(listName);
      list.shuffle();
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Visibility(
              visible:
                  StorageManager.readData(StorageManager.affectOnPractice) ==
                      true,
              child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: Margins.margin8, horizontal: Margins.margin24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: Margins.margin16),
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
                        padding: EdgeInsets.only(left: Margins.margin16),
                        child: Icon(Icons.auto_graph_rounded,
                            color: Colors.lightBlueAccent),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
              child: GridView.builder(
                itemCount: StudyModes.values.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1.2),
                itemBuilder: (context, index) {
                  return _modeBasedButtons(context, StudyModes.values[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Margins.margin16, bottom: Margins.margin16),
              child: Text("study_modes_good_luck".tr(),
                  style: Theme.of(context).textTheme.headline5),
            )
          ],
        ));
  }

  Widget _modeBasedButtons(BuildContext context, StudyModes mode) {
    return KPButton(
        title1: mode.japMode,
        title2: mode.mode,
        color: mode.color,
        onTap: () async {
          List<Kanji>? l = list;
          final navigator = Navigator.of(context);
          if (l != null) {
            if (l.isEmpty) {
              Navigator.of(context).pop();
              GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
            } else {
              await _decideOnMode(navigator, l, mode);
            }
          } else {
            List<Kanji> l = await _loadTest(mode);
            if (l.isEmpty) {
              navigator.pop();
              // ignore: use_build_context_synchronously
              GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
            } else {
              await _decideOnMode(navigator, l, mode);
            }
          }
        });
  }

  Future<void> _decideOnMode(
    NavigatorState navigator,
    List<Kanji> l,
    StudyModes mode,
  ) async {
    final displayTestName = type.name;
    final kanjiInTest =
        StorageManager.readData(StorageManager.numberOfKanjiInTest) ??
            CustomSizes.numberOfKanjiInTest;
    List<Kanji> sortedList =
        l.sublist(0, l.length < kanjiInTest ? l.length : kanjiInTest);
    navigator.pop(); // Dismiss this bottom sheet
    navigator.pop(); // Dismiss the tests bottom sheet

    /// Save to SharedPreferences the current folder, if any, to manage
    /// proper navigation when finishing the test.
    /// See addPostFrameCallback() in init() in [HomePage]
    StorageManager.saveData(StorageManager.folderWhenOnTest, folder ?? "");

    await navigator.pushNamed(
      mode.page,
      arguments: ModeArguments(
        studyList: sortedList,
        isTest: true,
        testMode: type,
        studyModeHeaderDisplayName: displayTestName,
        mode: mode,
        testHistoryDisplasyName: testName,
      ),
    );
  }
}
