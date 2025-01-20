import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/generic_test/generic_test_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class WordGrid extends StatelessWidget {
  final List<String>? selectionQuery;
  final Tests type;
  final String? folder;
  final String testName;
  final String? practiceList;
  const WordGrid({
    super.key,
    required this.type,
    required this.folder,
    required this.testName,
    this.selectionQuery,
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
    return BlocConsumer<GenericTestBloc, GenericTestState>(
      listener: ((context, state) async {
        state.mapOrNull(loaded: (l) async {
          List<Word> list = l.words;
          if (list.isEmpty) {
            Navigator.of(context).pop();
            context
                .read<SnackbarBloc>()
                .add(SnackbarEventShow("study_modes_empty".tr()));
          } else {
            await _decideOnMode(context, list, l.mode);
          }
        });
      }),
      builder: (context, state) {
        return state.maybeWhen(
          initial: (wordsToReview) => Padding(
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
                  crossAxisCount: 3, childAspectRatio: kIsWeb ? 1.6 : 1.2),
              itemBuilder: (context, i) {
                int? isAvailable = 0;
                final service = getIt<PreferencesService>();

                if (service.readData(SharedKeys.dailyTestOnControlledPace) ==
                        true &&
                    type == Tests.daily) {
                  switch (StudyModes.values[i]) {
                    case StudyModes.writing:
                      isAvailable =
                          service.readData(SharedKeys.writingDailyPerformed);
                      break;
                    case StudyModes.reading:
                      isAvailable =
                          service.readData(SharedKeys.readingDailyPerformed);
                      break;
                    case StudyModes.recognition:
                      isAvailable = service
                          .readData(SharedKeys.recognitionDailyPerformed);
                      break;
                    case StudyModes.listening:
                      isAvailable =
                          service.readData(SharedKeys.listeningDailyPerformed);
                      break;
                    case StudyModes.speaking:
                      isAvailable =
                          service.readData(SharedKeys.speakingDailyPerformed);
                      break;
                  }
                }

                return _modeBasedButtons(
                  context,
                  StudyModes.values[i],
                  isAvailable == 0 || isAvailable == null,
                  wordsToReview.isEmpty ? -1 : wordsToReview[i],
                );
              },
            ),
          ),
          orElse: () => const Center(child: KPProgressIndicator()),
        );
      },
    );
  }

  Widget _modeBasedButtons(
    BuildContext context,
    StudyModes mode,
    bool isAvailable,
    int wordsToReview,
  ) {
    String toReview = wordsToReview.toString();
    if (wordsToReview > 500) {
      toReview = "> 500";
    }

    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        KPButton(
          title1: mode.japMode,
          title2: mode.mode,
          color: isAvailable
              ? mode.color
              : Theme.of(context).colorScheme.inverseSurface,
          textColor: isAvailable
              ? Colors.white
              : Theme.of(context).colorScheme.onInverseSurface,
          onTap: isAvailable
              ? () async {
                  if (selectionQuery != null &&
                      selectionQuery?.isEmpty == true) {
                    Navigator.of(context).pop();
                    context
                        .read<SnackbarBloc>()
                        .add(SnackbarEventShow("study_modes_empty".tr()));
                  } else {
                    context.read<GenericTestBloc>().add(
                          GenericTestEventLoadList(
                            folder: folder,
                            mode: mode,
                            type: type,
                            practiceList: practiceList,
                            selectionQuery: selectionQuery,
                          ),
                        );
                  }
                }
              : null,
        ),
        if (wordsToReview > 0 && type == Tests.daily)
          Positioned(
            top: -KPMargins.margin12,
            right: -KPMargins.margin8,
            child: Chip(
              label: Text(
                toReview,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
              side: BorderSide.none,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              labelPadding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }
}
