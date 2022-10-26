import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/load_test_daily/load_test_daily_bloc.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
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

  @override
  Widget build(BuildContext context) {
    final title = folder != null ? ": $folder" : "";
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return BlocConsumer<LoadTestDailyBloc, LoadTestDailyState>(
          listener: (context, state) async {
            if (state is LoadTestDailyStateLoadedList) {
              final navigator = Navigator.of(context);
              final today = await Utils.parseTodayDate(context);

              navigator.pop(); // Dismiss this bottom sheet
              navigator.pop(); // Dismiss the tests bottom sheet

              final folderTitle = folder != null ? " - $folder" : "";
              final name = "${"abbr_test_mode_daily".tr()}: $today$folderTitle";

              /// Save to SharedPreferences the current folder, if any, to manage
              /// proper navigation when finishing the test.
              /// See addPostFrameCallback() in init() in [HomePage]
              getIt<PreferencesService>()
                  .saveData(SharedKeys.folderWhenOnTest, folder ?? "");
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: KPMargins.margin8,
                        horizontal: KPMargins.margin32),
                    child: Text("${"daily_test_bottom_sheet_title".tr()}$title",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Visibility(
                    visible: getIt<PreferencesService>()
                            .readData(SharedKeys.affectOnPractice) ==
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
                    onTap: () {
                      getIt<LoadTestDailyBloc>()
                          .add(LoadTestDailyEventLoadList(folder: folder));
                    },
                  ),
                  const SizedBox(height: KPMargins.margin16),
                ],
              ),
            ]);
          },
        );
      },
    );
  }
}
