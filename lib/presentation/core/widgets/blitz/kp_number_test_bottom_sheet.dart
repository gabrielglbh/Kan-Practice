import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/number_ranges.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class KPNumberTestBottomSheet extends StatefulWidget {
  const KPNumberTestBottomSheet({super.key});

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const KPNumberTestBottomSheet());
  }

  @override
  State<KPNumberTestBottomSheet> createState() =>
      _KPNumberTestBottomSheetState();
}

class _KPNumberTestBottomSheetState extends State<KPNumberTestBottomSheet> {
  final List<Ranges> _selectedLists = [];
  int _wordsInTest = KPSizes.numberOfWordInTest;

  List<Word> _loadBlitzTest() {
    /// If no range is selected, 0 to 10K will be taken
    int min = Ranges.from0to1K.min;
    int max = Ranges.from1Kto10K.max;
    final random = Random();

    /// Sort the list of selected ranges to properly apply the min and max
    _selectedLists.sort((a, b) => a.index.compareTo(b.index));
    if (_selectedLists.isNotEmpty) {
      min = _selectedLists[0].min;
      max = _selectedLists[_selectedLists.length - 1].max;
    }

    return List.generate(_wordsInTest, (n) {
      String num = (min + random.nextInt((max + 1) - min)).toString();
      return Word(
          word: num, pronunciation: num, meaning: num, listName: "Numbers");
    });
  }

  @override
  void initState() {
    _wordsInTest =
        getIt<PreferencesService>().readData(SharedKeys.numberOfWordInTest) ??
            KPSizes.numberOfWordInTest;
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
                child: Text("number_bottom_sheet_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text(
                    "$_wordsInTest "
                    "${"number_bottom_sheet_content".tr()}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(height: KPMargins.margin16),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 4),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Ranges.values.length,
                itemBuilder: (context, index) {
                  Ranges range = Ranges.values[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: KPMargins.margin8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedLists.contains(range)) {
                            _selectedLists.remove(range);
                          } else {
                            _selectedLists.add(range);
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: KPMargins.margin8,
                            vertical: KPMargins.margin2),
                        decoration: BoxDecoration(
                          color: _selectedLists.contains(range)
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(KPRadius.radius16),
                          border: Border.all(
                            color: _selectedLists.contains(range)
                                ? Colors.transparent
                                : Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        child: Text(
                          range.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: _selectedLists.contains(range)
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: KPMargins.margin16),
              _numberButton(context, "number_bottom_sheet_label".tr()),
              const SizedBox(height: KPMargins.margin8),
            ],
          ),
        ]);
      },
    );
  }

  Widget _numberButton(BuildContext context, String listsNames) {
    return Column(
      children: [
        KPButton(
            title1: "number_bottom_sheet_begin_ext".tr(),
            title2: "number_bottom_sheet_begin".tr(),
            onTap: () async {
              List<Word> list = _loadBlitzTest();
              if (list.isEmpty) {
                Navigator.of(context).pop();
                context
                    .read<SnackbarBloc>()
                    .add(SnackbarEventShow("study_modes_empty".tr()));
              } else {
                Navigator.of(context).pop(); // Dismiss this bottom sheet
                Navigator.of(context).pop(); // Dismiss the tests bottom sheet
                await Navigator.of(context).pushNamed(
                    KanPracticePages.listeningStudyPage,
                    arguments: ModeArguments(
                        studyList: list,
                        isTest: true,
                        mode: StudyModes.listening,
                        testMode: Tests.numbers,
                        studyModeHeaderDisplayName: "test_mode_number".tr(),
                        testHistoryDisplasyName: listsNames,
                        isNumberTest: true));
              }
            }),
      ],
    );
  }
}
