import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class KPTestStudyMode extends StatefulWidget {
  /// List of [Kanji] to make the test with.
  ///
  /// If [list] is null, the list must be loaded upon the mode selection (BLITZ or REMEMBRANCE or LESS % or DAILY).
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
  State<KPTestStudyMode> createState() => _KPTestStudyModeState();
}

class _KPTestStudyModeState extends State<KPTestStudyMode> {
  @override
  void initState() {
    getIt<LoadTestBloc>().add(LoadTestEventIdle(mode: widget.type));
    super.initState();
  }

  Widget affectOnPractice() {
    return Visibility(
      visible:
          getIt<PreferencesService>().readData(SharedKeys.affectOnPractice) ==
              true,
      child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: KPMargins.margin8, horizontal: KPMargins.margin24),
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
    );
  }

  Widget controlledPace() {
    final controlledPace = getIt<PreferencesService>()
            .readData(SharedKeys.dailyTestOnControlledPace) ==
        true;
    return Visibility(
      visible: controlledPace && widget.type == Tests.daily,
      child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: KPMargins.margin8, horizontal: KPMargins.margin24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: KPMargins.margin16),
                child: Icon(Icons.sports_gymnastics_rounded,
                    color: KPColors.getSubtle(context)),
              ),
              Expanded(
                  child: Text(
                "test_info_controlled_pace".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              )),
              Padding(
                padding: const EdgeInsets.only(left: KPMargins.margin16),
                child: Icon(Icons.sports_gymnastics_rounded,
                    color: KPColors.getSubtle(context)),
              ),
            ],
          )),
    );
  }

  int get _modesLegnth => widget.type == Tests.daily
      ? StudyModes.values.length + GrammarModes.values.length
      : StudyModes.values.length;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          affectOnPractice(),
          controlledPace(),
          // TODO: Grammar loading on LoadTestBloc
          BlocConsumer<LoadTestBloc, LoadTestState>(
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
              // TODO: Make a PageView with Words - Grammar modes
              if (state is LoadTestStateIdle) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: KPMargins.margin16,
                    left: KPMargins.margin16,
                    bottom: KPMargins.margin8,
                  ),
                  child: GridView.builder(
                    itemCount: _modesLegnth,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1.2),
                    itemBuilder: (context, i) {
                      // TODO: LoadTestBloc, grammarToReview
                      if (widget.type == Tests.daily && i == _modesLegnth - 1) {
                        return _grammarButton(
                          context,
                          GrammarModes.values[0],
                          -1,
                        );
                      }
                      return _modeBasedButtons(
                        context,
                        StudyModes.values[i],
                        state.wordsToReview.isEmpty
                            ? -1
                            : state.wordsToReview[i],
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: KPProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }

  Widget _grammarButton(
    BuildContext context,
    GrammarModes mode,
    int grammarToReview,
  ) {
    String toReview = grammarToReview.toString();
    if (grammarToReview > 5000) {
      toReview = "> 5000";
    }
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        KPButton(
          title1: mode.japMode,
          title2: mode.mode,
          color: mode.color,
          onTap: () async {
            // TODO: Load grammar for daily test
          },
        ),
        if (grammarToReview > 0)
          Positioned(
            top: -KPMargins.margin12,
            right: -KPMargins.margin8,
            child: Chip(
              label: Text(
                toReview,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white),
              ),
              backgroundColor: KPColors.secondaryDarkerColor,
              labelPadding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }

  Widget _modeBasedButtons(
    BuildContext context,
    StudyModes mode,
    int wordsToReview,
  ) {
    String toReview = wordsToReview.toString();
    if (wordsToReview > 5000) {
      toReview = "> 5000";
    }
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        KPButton(
          title1: mode.japMode,
          title2: mode.mode,
          color: mode.color,
          onTap: () async {
            List<Word>? l = widget.list;
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
                  folder: widget.folder,
                  mode: mode,
                  type: widget.type,
                  practiceList: widget.practiceList,
                ),
              );
            }
          },
        ),
        if (wordsToReview > 0)
          Positioned(
            top: -KPMargins.margin12,
            right: -KPMargins.margin8,
            child: Chip(
              label: Text(
                toReview,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white),
              ),
              backgroundColor: KPColors.secondaryDarkerColor,
              labelPadding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }

  Future<void> _decideOnMode(
    BuildContext context,
    List<Word> list,
    StudyModes mode,
  ) async {
    final displayTestName = widget.type.name;
    Navigator.of(context).pop(); // Dismiss this bottom sheet
    Navigator.of(context).pop(); // Dismiss the tests bottom sheet

    /// Save to SharedPreferences the current folder, if any, to manage
    /// proper navigation when finishing the test.
    /// See addPostFrameCallback() in init() in [HomePage]
    getIt<PreferencesService>()
        .saveData(SharedKeys.folderWhenOnTest, widget.folder ?? "");

    await Navigator.of(context).pushNamed(
      mode.page,
      arguments: ModeArguments(
        studyList: list,
        isTest: true,
        testMode: widget.type,
        studyModeHeaderDisplayName: displayTestName,
        mode: mode,
        testHistoryDisplasyName: widget.testName,
      ),
    );
  }
}
