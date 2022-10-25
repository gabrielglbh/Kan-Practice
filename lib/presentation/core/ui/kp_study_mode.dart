import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class KPTestStudyMode extends StatelessWidget {
  /// List of [Kanji] to make the test with.
  ///
  /// If [list] is null, the list must be loaded upon the mode selection (BLITZ or REMEMBRANCE or LESS %).
  ///
  /// If it is not null, the list must come from (SELECTION OR CATEGORY TEST).
  final List<Word>? list;

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadTestBloc, LoadTestState>(
      listener: ((context, state) async {
        if (state is LoadTestStateLoadedList) {
          List<Word> list = state.words;
          if (list.isEmpty) {
            Navigator.of(context).pop();
            Utils.getSnackBar(context, "study_modes_empty".tr());
          } else {
            await _decideOnMode(context, list, state.mode);
          }
        }
      }),
      builder: (context, state) {
        return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
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
                      )),
                ),
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
            ));
      },
    );
  }

  Widget _modeBasedButtons(BuildContext context, StudyModes mode) {
    return KPButton(
        title1: mode.japMode,
        title2: mode.mode,
        color: mode.color,
        onTap: () async {
          List<Word>? l = list;
          if (l != null) {
            if (l.isEmpty) {
              Navigator.of(context).pop();
              Utils.getSnackBar(context, "study_modes_empty".tr());
            } else {
              await _decideOnMode(context, l, mode);
            }
          } else {
            getIt<LoadTestBloc>().add(
              LoadTestEventLoadList(
                folder: folder,
                mode: mode,
                type: type,
                practiceList: practiceList,
              ),
            );
          }
        });
  }

  Future<void> _decideOnMode(
    BuildContext context,
    List<Word> list,
    StudyModes mode,
  ) async {
    final displayTestName = type.name;
    Navigator.of(context).pop(); // Dismiss this bottom sheet
    Navigator.of(context).pop(); // Dismiss the tests bottom sheet

    /// Save to SharedPreferences the current folder, if any, to manage
    /// proper navigation when finishing the test.
    /// See addPostFrameCallback() in init() in [HomePage]
    getIt<PreferencesService>()
        .saveData(SharedKeys.folderWhenOnTest, folder ?? "");

    await Navigator.of(context).pushNamed(
      mode.page,
      arguments: ModeArguments(
        studyList: list,
        isTest: true,
        testMode: type,
        studyModeHeaderDisplayName: displayTestName,
        mode: mode,
        testHistoryDisplasyName: testName,
      ),
    );
  }
}
