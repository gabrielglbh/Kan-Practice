import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class DailyBottomSheet extends StatelessWidget {
  const DailyBottomSheet({Key? key}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const DailyBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return BlocConsumer<LoadTestBloc, LoadTestState>(
          listener: (context, state) async {
            if (state is LoadTestStateLoadedList) {
              final navigator = Navigator.of(context);
              final today = await Utils.parseTodayDate(context);

              navigator.pop(); // Dismiss this bottom sheet
              navigator.pop(); // Dismiss the tests bottom sheet

              final name = "${"abbr_test_mode_daily".tr()}: $today";
              await navigator.pushNamed(
                state.mode.page,
                arguments: ModeArguments(
                  studyList: state.words,
                  isTest: true,
                  testMode: Tests.daily,
                  studyModeHeaderDisplayName: Tests.daily.name,
                  mode: state.mode,
                  testHistoryDisplasyName: name,
                ),
              );
            }
          },
          builder: (context, state) {
            return Wrap(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KPDragContainer(),
                  Row(
                    children: [
                      const SizedBox(width: KPMargins.margin48),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: KPMargins.margin8,
                              horizontal: KPMargins.margin32),
                          child: Text("daily_test_bottom_sheet_title".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline_rounded),
                        onPressed: () {
                          Utils.launch(context,
                              'https://en.wikipedia.org/wiki/SuperMemo');
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: KPMargins.margin8,
                        horizontal: KPMargins.margin32),
                    child: Text("daily_test_description".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  KPTestStudyMode(
                    type: Tests.daily,
                    testName: Tests.daily.name,
                  )
                ],
              ),
            ]);
          },
        );
      },
    );
  }
}
