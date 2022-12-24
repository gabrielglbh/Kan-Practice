import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class WordGrid extends StatelessWidget {
  final List<Word>? list;
  final Tests type;
  final String? folder;
  final String testName;
  final String? practiceList;
  const WordGrid({
    super.key,
    required this.type,
    required this.folder,
    required this.testName,
    this.list,
    this.practiceList,
  });

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
        if (state is LoadTestStateIdle) {
          return Padding(
            padding: const EdgeInsets.only(
              right: KPMargins.margin16,
              left: KPMargins.margin16,
              bottom: KPMargins.margin8,
            ),
            child: GridView.builder(
              itemCount: StudyModes.values.length,
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.2),
              itemBuilder: (context, i) {
                return _modeBasedButtons(
                  context,
                  StudyModes.values[i],
                  state.wordsToReview.isEmpty ? -1 : state.wordsToReview[i],
                );
              },
            ),
          );
        } else {
          return const Center(child: KPProgressIndicator());
        }
      },
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
}
