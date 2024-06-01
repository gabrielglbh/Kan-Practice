import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/grammar_test/grammar_test_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_arguments.dart';

class GrammarGrid extends StatelessWidget {
  final List<String>? selectionQuery;
  final Tests type;
  final String? folder;
  final String testName;
  final String? practiceList;
  const GrammarGrid({
    super.key,
    required this.type,
    required this.folder,
    required this.testName,
    required this.practiceList,
    this.selectionQuery,
  });

  Future<void> _decideOnGrammarMode(
    BuildContext context,
    List<GrammarPoint> list,
    GrammarModes mode,
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
      arguments: GrammarModeArguments(
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
    return BlocConsumer<GrammarTestBloc, GrammarTestState>(
      listener: ((context, state) async {
        state.mapOrNull(
          loaded: (l) async {
            List<GrammarPoint> list = l.grammar;
            if (list.isEmpty) {
              Navigator.of(context).pop();
              context
                  .read<SnackbarBloc>()
                  .add(SnackbarEventShow("study_modes_empty".tr()));
            } else {
              await _decideOnGrammarMode(context, list, l.mode);
            }
          },
        );
      }),
      builder: (context, state) {
        return state.maybeWhen(
          initial: (grammarToReview) => Padding(
            padding: const EdgeInsets.only(
              right: KPMargins.margin16,
              left: KPMargins.margin16,
              bottom: KPMargins.margin8,
            ),
            child: GridView.builder(
              itemCount: GrammarModes.values.length,
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.2),
              itemBuilder: (context, i) {
                int? isAvailable = 0;
                final service = getIt<PreferencesService>();

                if (service.readData(SharedKeys.dailyTestOnControlledPace) ==
                        true &&
                    type == Tests.daily) {
                  switch (GrammarModes.values[i]) {
                    case GrammarModes.definition:
                      isAvailable =
                          service.readData(SharedKeys.definitionDailyPerformed);
                      break;
                    case GrammarModes.grammarPoints:
                      isAvailable = service
                          .readData(SharedKeys.grammarPointDailyPerformed);
                      break;
                  }
                }

                return _grammarButton(
                  context,
                  GrammarModes.values[i],
                  isAvailable == 0 || isAvailable == null,
                  grammarToReview.isEmpty ? -1 : grammarToReview[i],
                );
              },
            ),
          ),
          orElse: () => const Center(child: KPProgressIndicator()),
        );
      },
    );
  }

  Widget _grammarButton(
    BuildContext context,
    GrammarModes mode,
    bool isAvailable,
    int grammarToReview,
  ) {
    String toReview = grammarToReview.toString();
    if (grammarToReview > 500) {
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
                    context.read<GrammarTestBloc>().add(
                          GrammarTestEventLoadList(
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
        if (grammarToReview > 0 && type == Tests.daily)
          Positioned(
            top: -KPMargins.margin12,
            right: -KPMargins.margin8,
            child: Chip(
              label: Text(
                toReview,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onTertiary),
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
