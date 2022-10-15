import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/pages/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';

class PracticeFolderBottomSheet extends StatefulWidget {
  final String folder;

  const PracticeFolderBottomSheet({Key? key, required this.folder})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular folder practice
  static Future<void> show(BuildContext context, String folder) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => PracticeFolderBottomSheet(folder: folder));
  }

  @override
  State<PracticeFolderBottomSheet> createState() =>
      _PracticeFolderBottomSheetState();
}

class _PracticeFolderBottomSheetState extends State<PracticeFolderBottomSheet> {
  Future<List<Kanji>> _loadPractice(StudyModes mode) async {
    List<Kanji> list = await FolderQueries.instance
        .getAllKanjiOnListsOnFolder([widget.folder]);
    list.shuffle();
    return list;
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                    "${"list_details_practice_button_label".tr()}: ${widget.folder}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Margins.margin8, horizontal: Margins.margin32),
                child: Text("folder_practice_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Margins.margin16,
                      left: Margins.margin16,
                      bottom: Margins.margin8,
                    ),
                    child: GridView.builder(
                      itemCount: StudyModes.values.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.2),
                      itemBuilder: (context, index) {
                        return _modeBasedButtons(
                            context, StudyModes.values[index]);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ]);
      },
    );
  }

  Widget _modeBasedButtons(BuildContext context, StudyModes mode) {
    return KPButton(
      title1: mode.japMode,
      title2: mode.mode,
      color: mode.color,
      onTap: () async {
        final navigator = Navigator.of(context);
        List<Kanji> l = await _loadPractice(mode);
        if (l.isEmpty) {
          // ignore: use_build_context_synchronously
          GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
        } else {
          await _decideOnMode(navigator, l, mode);
        }
      },
    );
  }

  Future<void> _decideOnMode(
    NavigatorState navigator,
    List<Kanji> l,
    StudyModes mode,
  ) async {
    final kanjiInTest =
        StorageManager.readData(StorageManager.numberOfKanjiInTest) ??
            CustomSizes.numberOfKanjiInTest;
    List<Kanji> sortedList =
        l.sublist(0, l.length < kanjiInTest ? l.length : kanjiInTest);
    navigator.pop(); // Dismiss this bottom sheet

    await navigator.pushNamed(
      mode.page,
      arguments: ModeArguments(
        studyList: sortedList,
        isTest: false,
        testMode: Tests.blitz,
        studyModeHeaderDisplayName: widget.folder,
        mode: mode,
      ),
    );
  }
}