import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/general_utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class PracticeListBottomSheet extends StatefulWidget {
  final String listName;
  final List<Kanji> list;
  const PracticeListBottomSheet({
    Key? key,
    required this.listName,
    required this.list,
  }) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular list practice
  /// when the GROUP mode is active only
  static Future<void> show(
      BuildContext context, String listName, List<Kanji> list) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            PracticeListBottomSheet(listName: listName, list: list));
  }

  @override
  State<PracticeListBottomSheet> createState() =>
      _PracticeListBottomSheetState();
}

class _PracticeListBottomSheetState extends State<PracticeListBottomSheet> {
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
                    "${"list_details_practice_button_label".tr()}: ${widget.listName}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
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
        if (widget.list.isEmpty) {
          // ignore: use_build_context_synchronously
          GeneralUtils.getSnackBar(context, "study_modes_empty".tr());
        } else {
          widget.list.shuffle();
          await _decideOnMode(widget.list, mode);
        }
      },
    );
  }

  Future<void> _decideOnMode(List<Kanji> l, StudyModes mode) async {
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
