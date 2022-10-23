import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/infrastructure/folder/folder_repository_impl.dart';
import 'package:kanpractice/infrastructure/preferences/preferences_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

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
  Future<List<Word>> _loadPractice(StudyModes mode) async {
    List<Word> list = await getIt<FolderRepositoryImpl>()
        .getAllWordsOnListsOnFolder([widget.folder]);
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
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text(
                    "${"list_details_practice_button_label".tr()}: ${widget.folder}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("folder_practice_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: KPMargins.margin16,
                      left: KPMargins.margin16,
                      bottom: KPMargins.margin8,
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
        List<Word> l = await _loadPractice(mode);
        if (l.isEmpty) {
          // ignore: use_build_context_synchronously
          Utils.getSnackBar(context, "study_modes_empty".tr());
        } else {
          await _decideOnMode(navigator, l, mode);
        }
      },
    );
  }

  Future<void> _decideOnMode(
    NavigatorState navigator,
    List<Word> l,
    StudyModes mode,
  ) async {
    final kanjiInTest = getIt<PreferencesRepositoryImpl>()
            .readData(SharedKeys.numberOfKanjiInTest) ??
        KPSizes.numberOfKanjiInTest;
    List<Word> sortedList =
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
