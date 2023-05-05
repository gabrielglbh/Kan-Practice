import 'package:flutter/material.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_arguments.dart';

class PracticeGrammarBottomSheet extends StatefulWidget {
  final String listName;
  final List<GrammarPoint> list;
  const PracticeGrammarBottomSheet({
    Key? key,
    required this.listName,
    required this.list,
  }) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular list practice
  /// when the GROUP mode is active only
  static Future<void> show(
      BuildContext context, String listName, List<GrammarPoint> list) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            PracticeGrammarBottomSheet(listName: listName, list: list));
  }

  @override
  State<PracticeGrammarBottomSheet> createState() =>
      _PracticeGrammarBottomSheetState();
}

class _PracticeGrammarBottomSheetState
    extends State<PracticeGrammarBottomSheet> {
  List<GrammarPoint> grammarList = [];

  @override
  void initState() {
    grammarList.addAll(widget.list);
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
                      bottom: KPMargins.margin32,
                    ),
                    child: GridView.builder(
                      itemCount: GrammarModes.values.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.2),
                      itemBuilder: (context, index) {
                        return _modeBasedButtons(
                            context, GrammarModes.values[index]);
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

  Widget _modeBasedButtons(BuildContext context, GrammarModes mode) {
    return KPButton(
      title1: mode.japMode,
      title2: mode.mode,
      color: mode.color,
      onTap: () async {
        if (widget.list.isEmpty) {
          // ignore: use_build_context_synchronously
          Utils.getSnackBar(context, "study_modes_empty".tr());
        } else {
          grammarList.shuffle();
          await _decideOnMode(grammarList, mode);
        }
      },
    );
  }

  Future<void> _decideOnMode(List<GrammarPoint> l, GrammarModes mode) async {
    final navigator = Navigator.of(context);
    await navigator
        .pushNamed(
          mode.page,
          arguments: GrammarModeArguments(
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
