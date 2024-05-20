import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class PracticeWordsBottomSheet extends StatefulWidget {
  final String listName;
  final List<Word> list;
  const PracticeWordsBottomSheet({
    super.key,
    required this.listName,
    required this.list,
  });

  /// Creates and calls the [BottomSheet] with the content for a regular list practice
  /// when the GROUP mode is active only
  static Future<void> show(
      BuildContext context, String listName, List<Word> list) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            PracticeWordsBottomSheet(listName: listName, list: list));
  }

  @override
  State<PracticeWordsBottomSheet> createState() =>
      _PracticeWordsBottomSheetState();
}

class _PracticeWordsBottomSheetState extends State<PracticeWordsBottomSheet> {
  List<Word> wordList = [];

  @override
  void initState() {
    wordList.addAll(widget.list);
    super.initState();
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
                    "${"list_details_practice_button_label".tr()}: ${widget.listName}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
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
        if (widget.list.isEmpty) {
          // ignore: use_build_context_synchronously
          Utils.getSnackBar(context, "study_modes_empty".tr());
        } else {
          wordList.shuffle();
          await _decideOnMode(wordList, mode);
        }
      },
    );
  }

  Future<void> _decideOnMode(List<Word> l, StudyModes mode) async {
    final navigator = Navigator.of(context);
    await navigator
        .pushNamed(
          mode.page,
          arguments: ModeArguments(
            studyList: l,
            isTest: false,
            testMode: Tests.blitz,
            studyModeHeaderDisplayName: widget.listName,
            mode: mode,
          ),
        )
        .then((value) => navigator.pop());
  }
}
